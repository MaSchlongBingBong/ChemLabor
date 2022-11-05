extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cvitem
var font
var drawn = false
var vport = Viewport.new()
var vport_img

# Called when the node enters the scene tree for the first time.
func _ready():
	font = DynamicFont.new()
	font.font_data = load("res://Font/CALIBRI.TTF")
	
	var size = Vector2(1024, 1024)

	vport.size = size
	# or Viewport.UPDATE_ONCE
	vport.render_target_update_mode = Viewport.UPDATE_ALWAYS 
	self.add_child(vport)
	cvitem = Control.new()
	vport.add_child(cvitem)
	cvitem.rect_min_size =  size
	cvitem.connect("draw",self,"draw")


func draw():
	if not drawn:
		cvitem.draw_string(font,Vector2(64,64), "I like Cock lol xD", Color(1,1,1,1))
		print("drawn")
		vport_img = vport.get_texture().get_data()
		vport_img.flip_y()
		vport_img.save_png("res://test.png")
		drawn = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
