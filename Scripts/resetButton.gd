extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal reset
var pressed: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.Instance.data["reset_button"] = self

func _pressed():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(_body):
	if not pressed:
		emit_signal("reset")
		pressed = true


func _on_Area_body_exited(_body):
	pressed = false
