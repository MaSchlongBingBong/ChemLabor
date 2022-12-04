extends "res://Scripts/Liquid.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cvitem
var drawn = false
var vport = Viewport.new()
var vport_img
var chemColor: Color

export var font_size = 40

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
	chemColor = Global.chemColors.get(chemical_name, Color(1,0,1,1))
	liquid.get_active_material(0).albedo_color = chemColor


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


# func _process(delta):
# 	var downness = self.transform.basis.y.dot(Vector3.DOWN)
# 	flowing = downness > 0.2
# 	flowing = flowing and not empty
# 	$Particles.emitting = flowing
# 	if flowing:
# 		empty = !Global.scaleLiquid(liquid,0.01,delta/5 * downness)
# 		var particles = $Particles
# 		#particles.process_material.direction = self.linear_velocity*10 + Vector3.UP
# 		particles.process_material.color = chemColor
	
# 		var space_state = get_world().direct_space_state
# 		var result = space_state.intersect_ray(particles.global_translation,particles.global_translation + Vector3.DOWN)
# 		var collider = result["collider"]
# 		if(collider.has_method("fill")):
# 			collider.call("fill",delta * downness * 5, chemical_name)
