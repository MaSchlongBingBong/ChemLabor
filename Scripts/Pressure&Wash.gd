extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isFlowing
var ethen
var dbe
var counter = 0
var liquid
# Called when the node enters the scene tree for the first time.
func _ready():
	liquid = Global.get_children_of_type(self, MeshInstance)[1]	
	isFlowing = false
	# Replace with function body.
func _onPressed(body:Node):
	print("help")
	print(body.get_groups())
	if body.is_in_group("Hands"):
		while !isFlowing:
			ethen = Global.loadScene(self, load("res://Scene/EthenParticals.tscn"))
			var newA = lerp(liquid.get_surface_material(0).albedo_color.a, 0, counter)
			if liquid.get_surface_material(0).albedo_color.a > 0.1:
				print(newA)
				liquid.get_surface_material(0).albedo_color.a = newA
				print("Applied new A")
			else:
				print("Done")
				ethen.queue_free()
				isFlowing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter = delta

func _onButtonPressed(body:Node):
	if body.is_in_group("Hands"):
		if dbe == null:
			dbe = Global.loadScene(self, load("res://Scene/flowingLiquid.tscn"))
			Global.scaleLiquid(liquid,0.01, counter/5)
		else:
			dbe.queue_free()

