extends "res://addons/godot-xr-tools/objects/pickable.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var copperoxid = load("res://Materials/Copperoxid.material")
var copperMat
var copper
var mat
var area
var fire
var timer = 10

func _ready():
	area = Global.get_child_of_type(self, Area)
	fire = Global.loadScene(self, load("res://Scene/Fire.tscn")).get_child(0)
	fire.emitting = true
	mat = fire.process_material
	fire.scale.y = 0.25 
	fire.translation.y = 0.19
	# Replace with function body.

func action():
	print("action")
	fire.emitting = !fire.emitting

func _process(delta):
	if fire.emitting:
		print(area)
		for body in area.get_overlapping_bodies():
			if body.has_method("oxidize"): #and body.get_meta("chemical") == "Dibromethan"#
				copperMat = Global.get_child_of_type(body, MeshInstance).get_active_material(0)
				body.call("oxidize", delta, copperoxid)
				print("green fire")
				mat.color = Color("#0e7310")
				fire.process_material = mat
				if copperMat == copperoxid:
					print("blue fire")
					mat.color = Color("#1624ef")
					fire.process_material = mat
		print("blue fire 2")
		mat.color = Color("#1624ef")
		fire.process_material = mat

