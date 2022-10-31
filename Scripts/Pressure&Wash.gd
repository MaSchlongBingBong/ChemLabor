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
	var ethen = Spatial.new()
	add_child(ethen)
	ethen.scale = Escale
	ethen.add_child(par)
	return ethen

func createDiBromEthen():
	pass


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
		if texture.albedo_color.a <= 0:
			ethen.queue_free()
			ethen = null
			print("Ethen:Done")
			var mesh = Global.get_children_of_type(self, MeshInstance)[1]
			var y = mesh.scale.y
			mesh.scale.y = lerp(mesh.scale.y, 0, (-counter/(time)))
			mesh.translation.y = mesh.scale.y - y
			print("Scale:Done")


func _onButtonPressed(body:Node):
	if body.is_in_group("Hands"):
		dbe = createDiBromEthen()
		var mesh = Global.get_children_of_type(self, MeshInstance)[1]
		var y = mesh.scale.y
		mesh.scale.y = lerp(mesh.scale.y, 0, (-counter/(time)+1))
		mesh.translation.y = mesh.scale.y - y

		
