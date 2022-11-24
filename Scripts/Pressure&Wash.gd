extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isFlowing = false
var ethen
var dbe
var counter = 0
var liquid
var newA
var dbeFlowing = false
var scaleLiquidDone = false

export var timer:int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	liquid = Global.get_children_of_type(self, MeshInstance)[1]	
	# Replace with function body.
func _onPressed(body:Node):
	print("help")
	print(body.get_groups())
	if body.is_in_group("Hands"):
		ethen = Global.loadScene(self, load("res://Scene/EthenParticals.tscn"))
		while !isFlowing:
			newA = lerp(liquid.get_surface_material(0).albedo_color.a, 0, counter)
			if liquid.get_surface_material(0).albedo_color.a > 0.1:
				liquid.get_surface_material(0).albedo_color.a = newA
			else:
				print("Done")
				ethen.queue_free()
				isFlowing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dbeFlowing:
		scaleLiquidDone = Global.scaleLiquid(liquid, 0.001, delta/timer)
		if !scaleLiquidDone:
			dbeFlowing = false
			dbe.queue_free();
			

func _onButtonPressed(body:Node):
	if body.is_in_group("Hands"):
		if dbe == null:
			dbe = Global.loadScene(self, load("res://Scene/flowingLiquid.tscn"))
			dbe.color = liquid.color
			dbeFlowing = true
