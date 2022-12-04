extends Spatial

var font
var cvitem
var vport = Viewport.new()
var vport_img

export var font_size = 60 

func _ready():
	self.add_child(vport)
	cvitem = Control.new()
	cvitem.set_script(load("res://Scripts/chalkboard.gd"))
	vport.add_child(cvitem)

func drawString(s):
	cvitem.set_meta("content", s)
	cvitem.set_meta("font_size", font_size)
	cvitem.draw()
