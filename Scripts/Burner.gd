extends "res://addons/godot-xr-tools/objects/pickable.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var copperoxid = load("res://Materials/Copperoxid.material")
var copperMat;
# Called when the node enters the scene tree for the first time.
var fire
func _ready():
	fire = Global.get_child_of_type(Global.loadScene(self, load("res://Scene/Fire.tscn")), Particles)
	fire.scale.y = 0.25 
	fire.translation.y = 0.19
	fire.emitting = false
	# Replace with function body.

func action():
	print("action")
	fire.emitting = !fire.emitting

func _onContact(body:Node):
	if body == self:
		return
	if body.is_in_group("copperPlate"):
		copperMat = Global.get_child_of_type(body, MeshInstance).get_active_material(0)
		if copperMat == copperoxid:
			pass
		elif fire:
			fire.color = Color("#0e7310")
			print("contact")
			yield(get_tree().create_timer(10.0), "timeout")
			body.changeColor(copperoxid)
			fire.color = Color("#1624ef")


func _onExit(body:Node):
	if body == self:
		return
	if fire != null:
		print("exit")



