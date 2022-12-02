extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 10
var mesh
var area 
var chemName
# Called when the node enters the scene tree for the first time.
func _ready():
	mesh = Global.get_child_of_type(self,MeshInstance)
	area = Global.get_child_of_type(self, Area)

func changeColor(copperoxid):
	mesh.set_surface_material(0, copperoxid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in area.get_overlapping_areas():
		if "chemical_name" in body:
			self.set_meta("chemical", body.get("chemical_name"))

func oxidize(delta, mat):
	print("now oxidzing biaaatch")
	timer -= delta
	if timer <= 0:
		changeColor(mat)
