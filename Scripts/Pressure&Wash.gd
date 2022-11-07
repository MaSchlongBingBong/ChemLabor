extends "res://addons/godot-xr-tools/objects/pickable.gd"

export var amount:int = 100
export var lifetime:int = 1
export var localcords:bool = false
export var drawOrder:int = 1
export var emissionShape:int = 1
export var emissionSphereRadius:float = 0.05
export var direction:Vector3 = Vector3(0,-1,0)
export var gravity: Vector3 = Vector3(0,-4,0)
export var accel:float = 60.0
export var accelRnd:float= 1.0 
export var drawPasses:int = 1
export var Pscale:float = 0.02
export var Escale:Vector3 = Vector3(1,1,1)
export var Cscale:Vector3 = Vector3(0.5,0.5,0.5)
export var time:float = 10 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isFlowing
var ethen
var dbe
var counter = 0
var texture = load("res://Materials/BromideWater.tres")
var scaleTexture = load("res://Materials/DibromEthen.res")
# Called when the node enters the scene tree for the first time.
func _ready():
	ethen = createEthen()
	# Replace with function body.


func createEthen():
	var par = Particles.new()
	var mesh = CubeMesh.new()
	mesh.size = Cscale
	par.draw_passes = drawPasses
	par.draw_pass_1 = mesh
	var mat = ParticlesMaterial.new()
	par.amount = amount
	par.lifetime = lifetime
	par.local_coords = localcords
	par.draw_order = drawOrder
	mat.emission_shape = emissionShape
	mat.emission_sphere_radius = emissionSphereRadius
	mat.direction = direction
	mat.gravity = gravity
	mat.linear_accel = accel
	mat.linear_accel_random = accelRnd
	mat.scale = Pscale
	par.process_material = mat
	var Ethen = Spatial.new()
	add_child(Ethen)
	Ethen.scale = Escale
	Ethen.add_child(par)
	return Ethen

func createDiBromEthen():
	var par = Particles.new()
	var mesh = CubeMesh.new()
	var mat = ParticlesMaterial.new()
	par.amount = 20
	par.lifetime = 0.75
	par.draw_passes = drawPasses
	par.draw_pass_1 = mesh
	mat.linear_accel = 100
	mat.scale_curve = scaleTexture
	par.process_material = mat
	par.scale = Vector3(0.01, 0.01, 0.01)
	var Dbe = Spatial.new()
	Dbe.name = "Dibromethen"
	Dbe.scale = Vector3(0.6, 0.16, 0.6)
	Dbe.translation = Vector3(-0.04, 0.05, 0.171)
	add_child(Dbe)
	Dbe.add_child(par)
	return Dbe

func _onPressed(body:Node):
	if isFlowing == false:
		if body.is_in_group("Hands"):
			ethen = createEthen()
			isFlowing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += delta
	if ethen != null:
		texture.albedo_color.a = lerp(1, 0, counter/time)
		if texture.albedo_color.a <= 0.25:
			ethen.queue_free()
			ethen = null
			print("Ethen:Done")
	if dbe != null:
		var mesh = Global.get_children_of_type(self, MeshInstance)[1]
		var yStart = 0.025
		var yEnd = 0.006
		mesh = Global.lerpLiquid(mesh, yStart, yEnd, counter/time)
		dbe.queue_free()
		dbe = null
		print(mesh.scale.y)
		print("Scale:Done")

func _onButtonPressed(body:Node):
	if body.is_in_group("Hands"):
		if ethen == null && isFlowing:
			dbe = createDiBromEthen()
