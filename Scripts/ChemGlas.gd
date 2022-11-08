extends "res://addons/godot-xr-tools/objects/pickable.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cvitem
var drawn = false
var vport = Viewport.new()
var vport_img
var liquid: MeshInstance

export var font_size = 40
export var chemical_name = "Ethen"

# Called when the node enters the scene tree for the first time.
func _ready():
	# or Viewport.UPDATE_ONCE
	vport.render_target_update_mode = Viewport.UPDATE_ALWAYS 
	self.add_child(vport)
	cvitem = Control.new()
	cvitem.set_script(load("res://Scripts/Draw.gd"))
	vport.add_child(cvitem)
	#vport.add_child(Panel.new())
	# var mat = SpatialMaterial.new()
	# mat.albedo_texture = ViewportTexture.new()
	# mat.albedo_texture.viewport_path = vport.get_path()
	# $MeshInstance.set_surface_material(0,mat)
	cvitem.connect("finished_draw",self,"draw")
	drawString(chemical_name)
	liquid = $Liquid


func drawString(s):
	# var l = len(s)
	# var size = Vector2(l, 1.4) * font_size
	# cvitem.font.size = font_size
	# size = cvitem.font.get_string_size(s)
	# vport.size = size
	# cvitem.rect_min_size =  size
	cvitem.set_meta("content", s)#("%30s" % s) + "  ")
	cvitem.set_meta("font_size", font_size)
	cvitem.draw()
	pass

func draw():
	yield(get_tree().create_timer(1), "timeout")
	var img = vport.get_texture().get_data()
	img.flip_y()
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	var mat = SpatialMaterial.new()
	mat.albedo_texture = tex
	var mesh = Global.get_child_of_type(get_child(0),MeshInstance)
	mesh.get_surface_material(1).albedo_color = Color(1,1,1,1)
	mesh.get_surface_material(1).albedo_texture = tex
	vport_img = vport.get_texture().get_data()
	vport_img.flip_y()
	vport_img.save_png("res://test.png")
	print("saved")



func _process(delta):
	# var scale = liquid.scale.y
	# if scale < 0.01:
	# 	return;
	# liquid.scale.y -= .0005
	# var ds = liquid.scale.y - scale
	# print(ds)
	# liquid.translate(Vector3(0,ds/2 * 0.12,0))
	Global.scaleLiquid(liquid,0.01,delta/10)
