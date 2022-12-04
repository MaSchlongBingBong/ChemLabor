extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AudioButton_pressed_on():
	AudioServer.set_bus_mute(0,false)


func _on_AudioButton_pressed_off():
	AudioServer.set_bus_mute(0,true)


func _on_ResetButton_pressed_on():
	Global.data["sequence"].reset()
	pass # Replace with function body.
