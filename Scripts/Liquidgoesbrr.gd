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
	liquidColor = liquid.get_surface_material(0).albedo_color
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
				Global.scaleLiquid(liquid, 0.02, delta)
	if ethen.emitting:
		newAlpha = lerp(liquidColor.a, 0, delta/10)
		if liquidColor.a >= 0.125:
			liquidColor.a = newAlpha
			print(liquidColor.a)
		else:
			print("Stopping ethenflow")
			ethen.emitting = !ethen.emitting
		

func _onEthenPressed(body):
	if body.is_in_group("Hands"):
		ethen.emitting = !ethen.emitting

func _onDbePressed(body):
	if body.is_in_group("Hands"):
		dbe.emitting = !dbe.emitting
