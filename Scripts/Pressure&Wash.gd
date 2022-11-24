extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ethen
var dbe
var counter = 0
var liquid
var newAlpha
var mat

export var timer:int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	dbe = Global.get_child_of_type(Global.loadScene(self, load("res://Scene/flowingLiquid.tscn")) , Particles)
	mat = dbe.process_material
	dbe.emitting = false
	ethen = Global.get_child_of_type(Global.loadScene(self, load("res://Scene/EthenParticals.tscn")) , Particles)
	ethen.emitting = false
	liquid = Global.get_children_of_type(self, MeshInstance)[1]	
	# Replace with function body.
func _onPressed(body:Node):
	print("help")
	print(body.get_groups())
	if body.is_in_group("Hands"):
		ethen.emitting = !ethen.emitting
		while ethen.emitting:
			newAlpha = lerp(liquid.get_surface_material(0).albedo_color.a, 0, counter)
			if liquid.get_surface_material(0).albedo_color.a > 0.1:
				liquid.get_surface_material(0).albedo_color.a = newAlpha
			else:
				print("Done")
				ethen.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dbe.emitting:	
		if !Global.scaleLiquid(liquid, 0.001, delta/timer):
			dbe.emitting = false
			
func _onButtonPressed(body:Node):
	if body.is_in_group("Hands"):
		dbe.emitting = !dbe.emmiting
		mat.color = liquid.color
		dbe.process_material = mat
