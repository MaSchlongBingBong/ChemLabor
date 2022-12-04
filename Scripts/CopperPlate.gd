extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 10
var mesh
var area 
var chemName

func _ready():
	mesh = Global.get_child_of_type(self,MeshInstance)
	area = Global.get_child_of_type(self, Area)

func changeColor(copperoxid):
	mesh.set_surface_material(0, copperoxid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in area.get_overlapping_bodies():
		if "chemical_name" in body:
			if body.chemical_name != "":
				self.set_meta("chemical", body.get("chemical_name"))

func oxidize(delta, mat):
	timer -= delta
	if timer <= 0:
		changeColor(mat)
