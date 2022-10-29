extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

static func get_child_of_type(node: Node, child_type):
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		if child is child_type:
			return child
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func changeColor(copperoxid):
	var mesh = get_child_of_type(self,MeshInstance)
	mesh.set_surface_material(0, copperoxid)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
