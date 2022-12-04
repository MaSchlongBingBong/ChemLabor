extends "res://addons/godot-xr-tools/objects/pickable.gd"

var area
var ethen
var dbe   
var liquid
var liquidColor
var newAlpha

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	liquid = Global.get_children_of_type(self, MeshInstance)[1]
	liquidColor = liquid.get_surface_material(0)
	area = Global.get_children_of_type(self, Area)[2]
	ethen = Global.loadScene(self, load("res://Scene/EthenParticals.tscn"))
	ethen.name = "Ethen"
	ethen = ethen.get_child(0)
	ethen.emitting = false
	dbe = Global.loadScene(self, load("res://Scene/flowingLiquid.tscn"))
	dbe.name = "Dibromethan"
	dbe = dbe.get_child(0)
	dbe.emitting = false
	
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dbe.emitting:
		dbe.process_material.color = liquidColor.albedo_color
		for body in area.get_overlapping_bodies():
			if body.has_method("fill"):
				body.call("fill", delta, "Dibromethan")
		if !Global.scaleLiquid(liquid, 0.001, delta/10):
			print("Done Scaling")
			dbe.emitting = false
	if ethen.emitting:
		newAlpha = lerp(liquidColor.albedo_color.a, 0, delta/10)
		if liquidColor.albedo_color.a >= 0.25:
			liquidColor.albedo_color.a = newAlpha
			liquid.set_surface_material(0, liquidColor)
		else:
			print("Stopping ethenflow")
			ethen.emitting = !ethen.emitting
		

func _onEthenPressed(body):
	print("ethen")
	if body.is_in_group("Hands"):
		if liquidColor.albedo_color.a > 0.125:
			ethen.emitting = !ethen.emitting

func _onDbePressed(body):
	print("dbe")
	if body.is_in_group("Hands"):
		if liquid.scale > 0.001:	
			dbe.emitting = !dbe.emitting
			yield(get_tree().create_timer(3), "timeout")

