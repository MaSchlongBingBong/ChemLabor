extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var water
var area 
var mat 
# Called when the node enters the scene tree for the first time.
func _ready():
	water = Global.loadScene(self, load("res://Scene/flowingLiquid.tscn"))
	water.name = "H2"
	water.translation = Vector3(-2.016, 0.5666, 0.001)
	water.scale = Vector3(0.012, 0.058, 0.012)
	water = water.get_child(0)
	mat = water.process_material
	area = Global.get_children_of_type(self, Area)[1]
	mat.color = Global.chemColors.get("H2")
	print("water")
	print(mat.color)
	water.process_material = mat
	water.emitting = true

func _process(delta):
	if water.emitting:
		for body in area.get_overlapping_bodies():
			if body.has_method("fill"):
				body.call("fill", delta, "H2")
		

func _on_Area_body_entered(body):
	if body.is_in_group("Hands"):
		water.emitting = !water.emitting
		yield(get_tree().create_timer(3), "timeout")
