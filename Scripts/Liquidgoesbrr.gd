extends RigidBody

var area
var ethen
var dbe   
var liquid

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	liquid = Global.get_children_of_type(self, MeshInstance)[0]
	area = Global.get_children_of_type(self, Area)[2]
	ethen = Global.loadScene(self, load("res://Scene/EthenParticals.tscn")).get_child(0)
	ethen.emitting = false
	dbe = Global.loadScene(self, load("res://Scene/flowingLiquid.tscn")).get_child(0)
	dbe.emitting = false
	
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dbe.emitting:
		for body in area.get_overlapping_bodies():
			if body.has_method("fill"):
				body.call("fill", delta, "Dibromethan")

func _onEthenPressed(body):
	if body.is_in_group("Hands"):
		ethen.emitting = !ethen.emitting
	if ethen.emitting:
		pass

		
	
func _onDbePressed(body):
	if body.is_in_group("Hands"):
		dbe.emitting = !dbe.emitting
