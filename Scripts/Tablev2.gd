extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var water

# Called when the node enters the scene tree for the first time.
func _ready():
	water = Global.get_child_of_type(Global.loadScene(self, load("res://Scene/flowingLiquid.tscn")) , Particles)
	water.emitting = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area_body_entered(body):
	if body.is_in_group("Hands"):
		water.emitting = !water.emitting
