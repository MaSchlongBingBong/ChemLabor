extends "res://addons/godot-xr-tools/objects/pickable.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var copperoxid = load("res://Materials/Copperoxid.material")
var copperMat;
var mat
# Called when the node enters the scene tree for the first time.
var fire
func _ready():
	fire = Global.loadScene(self, load("res://Scene/Fire.tscn")).get_child(0)
	mat = fire.process_material
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
			mat.Color = Color("#0e7310")
			fire.process_material = mat
			print("contact")
			yield(get_tree().create_timer(10.0), "timeout")
			body.changeColor(copperoxid)
			fire.Color = Color("#1624ef")
			fire.process_material = mat


func _onExit(body:Node):
	if body == self:
		return
	if fire != null:
		print("exit")



