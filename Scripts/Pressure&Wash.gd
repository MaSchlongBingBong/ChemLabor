extends "res://addons/godot-xr-tools/objects/pickable.gd"

export var amount:int = 100
export var lifetime:int = 8
export var localcords:bool = false
export var drawOrder:int = 1
export var emissionShape:int = 1
export var direction:Vector3 = Vector3(0,-1,0)
export var gravity: Vector3 = Vector3(0,-4,0)
export var accel:float = 60.0
export var accelRnd:float= 1.0 
export var drawPasses:int = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isFlowing
var ethen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func createParticle():
	var par = Particles.new()
	var mesh = CubeMesh.new()
	par.draw_passes = drawPasses
	par.draw_pass_1 = mesh
	var mat = ParticlesMaterial.new()
	par.amount = amount
	par.lifetime = lifetime
	par.local_coords = localcords
	par.draw_order = drawOrder
	mat.emission_shape = emissionShape
	mat.direction = direction
	mat.gravity = gravity
	mat.linear_accel = accel
	mat.linear_accel_random = accelRnd

func _onPressed(body:Node):
	if isFlowing == false:
		if body.is_in_group("Hands"):
			ethen = createParticle()
			isFlowing = true

	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
