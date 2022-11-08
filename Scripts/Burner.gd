extends "res://addons/godot-xr-tools/objects/pickable.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var copperoxid = load("res://Materials/Copperoxid.material")
# Called when the node enters the scene tree for the first time.
var fire
func _ready():
	print("Fire:")
	print(fire)
	# Replace with function body.

func action():
	print("action")
	if fire == null:
		fire = Global.loadScene(self,load("res://Scene/Fire.tscn"))
		fire.scale.y = 0.25 
		fire.translation.y = 0.19
		pass
	else:
		fire.queue_free()
		fire = null

func _onContact(body:Node):
	if body == self:
		return
	if body.is_in_group("copperPlate"):
		var copperMat = Global.get_child_of_type(body, MeshInstance).get_active_material(0)
		if copperMat == copperoxid:
			pass
		elif fire:
			fire.Color = Color("#0e7310")
			print("contact")
			yield(get_tree().create_timer(10.0), "timeout")
			body.changeColor(copperoxid)
			fire.Color = Color("#1624ef")

	
func _onExit(body:Node):
	if body == self:
		return
	if fire != null:
		print("exit")



