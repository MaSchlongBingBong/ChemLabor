extends Node


var Instance

var old_data = {}
var data = {}

signal dataChange

# Called when the node enters the scene tree for the first time.
func _ready():
	if Instance == null:
		Instance = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if old_data != data:
		emit_signal("dataChange")
		old_data = data
