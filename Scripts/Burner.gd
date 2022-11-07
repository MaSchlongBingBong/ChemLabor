extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fireScene = Global.loadScene(self,load("res://Scene/Fire.tscn"))
var fire = Global.get_children_of_type(fireScene, Particles)
# var copperoxid = load("res://Materials/Copperoxid.material")
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Fire Array:")
	print(fireScene)
	# Replace with function body.

# func action():
# 	print("action")
# 	if fire == null:
# 		# fire = spawnParticle(200, Pcolor)
# 		pass
# 	else:
# 		fire.queue_free()
# 		fire = null

# func _onContact(body:Node):
# 	if body == self:
# 		return
# 	if body.is_in_group("copperPlate"):
# 		var copperMat = Global.get_child_of_type(body, MeshInstance).get_active_material(0)
# 		if copperMat == copperoxid:
# 			pass
# 		elif fire:
# 			fire.queue_free()
# 			print("contact")
# 			yield(get_tree().create_timer(10.0), "timeout")
# 			body.changeColor(copperoxid)

	
# func _onExit(body:Node):
# 	if body == self:
# 		return
# 	if fire != null:
# 		fire.queue_free()
# 		print("exit")



