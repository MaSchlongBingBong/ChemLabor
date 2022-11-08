extends Control

var font
var shouldDraw = false

signal finished_draw

func _ready():
	print("cvitem ready")
	font = DynamicFont.new()
	font.font_data = load("res://Font/CALIBRI.TTF")
	update()

func draw():
	shouldDraw = true
	update()

func _draw():
	if font == null or not shouldDraw:
		return
	var size = get_meta("font_size")
	font.size = size
	var text = get_meta("content", "404 CHEM NOT FOUND")
	var rsize = font.get_string_size(text)
	if rsize.x > 865:
		printerr("TEXT TO BIG ! GO BUY LIFE AND THAN WRITE SHORTEER TEXT YOU STUPID LITTLE IDIOT")
	rsize.x = 865
	get_parent().size = rsize
	rect_min_size = rsize
	var rect = Rect2()
	rect.size = rsize
	rect.position = Vector2.ZERO
	draw_rect(rect,Color(0.5,0.5,0.5,1),true)
	draw_string(font,Vector2(0,rsize.y*0.9), text, Color(1,1,1,1))
	print("drawn")
	emit_signal("finished_draw")
	
