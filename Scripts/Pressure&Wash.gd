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
# Called when the node enters the scene tree for the first time.
func _ready():
	ethen = Global.loadScene(self, load("res://Scene/EthenParticals.tscn"))
	ethen.name = "Ethen"	
	dbe = Global.loadScene(self, load("res://Scene/flowingLiquid.tscn"))
	dbe.name = "Dbe"
	# Replace with function body.
func _onPressed(body:Node):
	if isFlowing == false:
		if body.is_in_group("Hands"):
			isFlowing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += delta

func _onButtonPressed(body:Node):
	pass
