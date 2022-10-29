extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnParticle(200)# Replace with function body.

func spawnParticle(amount: int):
	# particle properties
	var par = Particles.new()
	var mesh = QuadMesh.new()
	var meshMat = SpatialMaterial.new()
	var material = ParticlesMaterial.new()
	var aabb = AABB(Vector3(-4,-4,-4), Vector3(8,8,8))
	var curve = load("res://FireMats/FireCurve.tres")
	var colorRamp = load("res://FireMats/FireColor.tres")

	# Drawing
	draw(par, aabb, false, 2)
	# Draw passes
	drawPasses(par, 1, true, true, true, 1, meshMat, mesh)
	# material properties
	materialProperties(material, 6, 1, Vector3(0,1,0), Vector3(0,0,0), 5, 0.1, 40.0, 1.0, 4, 1, 360, 1.0, 0.03)

	material.scale_curve = curve
	material.color = Color(22,36,239,255)
	material.color_ramp = colorRamp
	par.process_material = material
	par.amount = amount
	par.restart()

func draw(par: Particles, pos: AABB, localCords: bool, drawOrder: int):
	par.visibility_aabb = pos
	par.local_coords = localCords
	par.draw_order = drawOrder

func drawPasses(par: Particles, drawPasses: int, transparent: bool, unshaded: bool, useAlbedo: bool, blendMode: int, meshMat: SpatialMaterial, mesh: QuadMesh):
	par.draw_passes = drawPasses
	meshMat.flags_transparent = transparent
	meshMat.flags_unshaded = unshaded
	meshMat.vertex_color_use_as_albedo = useAlbedo
	meshMat.params_blend_mode = blendMode
	mesh.material = meshMat
	par.draw_pass_1 = mesh
	
func materialProperties(material: ParticlesMaterial, trailDivisor: int, emissionShape: int, direction: Vector3, gravity: Vector3, initVel: float, initVelRnd: float, angVel: float, angVelRnd: float, linAccl: float, linAcclRnd: float, angle: int, angleRnd: float, scale: float):
	material.trail_divisor = trailDivisor
	material.emission_shape = emissionShape
	material.emission_sphere_radius = 0.01
	material.direction = direction
	material.spread = 0.0
	material.gravity = gravity
	material.initial_velocity = initVel
	material.initial_velocity_random = initVelRnd
	material.angular_velocity = angVel
	material.angular_velocity_random = angVelRnd
	material.linear_accel = linAccl
	material.linear_accel_random = linAcclRnd
	material.angle = angle
	material.angle_random = angleRnd 
	material.scale = scale
	material.scale_random = scale





		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
