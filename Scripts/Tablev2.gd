extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var water
var area 
# Called when the node enters the scene tree for the first time.
func _ready():
	water = Global.loadScene(self, load("res://Scene/flowingLiquid.tscn")).get_child(0)
	area = Global.get_children_of_type(self, Area)[1]
	water.emitting = false
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta):
	if water.emitting:
		for body in area.get_overlapping_bodies():
			if body.has_method("fill"):
				body.call("fill", delta, "H2")

func _on_Area_body_entered(body):
	if body.is_in_group("Hands"):
		water.emitting = !water.emitting
