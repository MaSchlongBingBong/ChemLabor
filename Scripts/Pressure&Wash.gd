extends "res://addons/godot-xr-tools/objects/pickable.gd"

export var time:float = 10 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isFlowing
var ethen
var dbe
var counter = 0
var liquid = Global.get_children_of_type(self, MeshInstance)[1]
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
			liquid.material[0].a
			isFlowing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += delta
	

func _onButtonPressed(body:Node):
	if body.is_in_group("Hands"):
		if dbe != null:
			pass
		elif dbe == null:
			dbe = Global.loadScene(self, load("res://Scene/flowingLiquid.tscn"))
			liquid = Global.lerpLiquid(liquid, 0.025, 0.003, counter/time)
