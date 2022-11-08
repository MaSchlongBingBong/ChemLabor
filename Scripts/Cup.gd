extends "res://addons/godot-xr-tools/objects/pickable.gd"

export var time:float = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0
var isFilled = false
var liquid = Global.get_children_of_type(self, MeshInstance)
# Called when the node enters the scene tree for the first time.
func _ready():
	print(liquid) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += delta
		# fillCup(liquid)


