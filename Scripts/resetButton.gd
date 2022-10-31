extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal pressed_on
signal pressed_off

var pressed: bool = false
export var state: bool = false
export var toggle: bool = false
var button_mesh

# Called when the node enters the scene tree for the first time.
func _ready():
	button_mesh = $Button/CollisionShape/MeshInstance
	connect("pressed_on", self, "pressedOn")
	connect("pressed_off", self, "pressedOff")
	if state:
		pressedOn()
		emit_signal("pressed_on")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pressedOn():
	button_mesh.get_active_material(0).albedo_color = Color(0,1,0,1)
	button_mesh.get_active_material(0).emission = Color(0,1,0,1)

func pressedOff():
	button_mesh.get_active_material(0).albedo_color = Color(1,0,0,1)
	button_mesh.get_active_material(0).emission = Color(1,0,0,1)


func _on_Area_body_entered(_body):
	if toggle:
		state = not state
		if state:
			emit_signal("pressed_on")
		else:
			emit_signal("pressed_off")
	elif not pressed:
		emit_signal("pressed_on")
	pressed = true


func _on_Area_body_exited(_body):
	if not toggle:
		emit_signal("pressed_off")
	pressed = false
