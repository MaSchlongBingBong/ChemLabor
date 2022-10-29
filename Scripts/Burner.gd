extends "res://addons/godot-xr-tools/objects/pickable.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var localCords:bool = false
export var drawOrder:int = 2
export var drawPasses:int = 1
export var transparent:bool = true
export var unshaded:bool = true
export var useAlbedo:bool = true
export var blendMode:int = 1
export var trailDivisor: int = 6
export var emissionShape: int = 1
export var direction: Vector3 = Vector3(0,1,0)
export var gravity: Vector3 = Vector3(0,0,0)
export var initVel: int = 5
export var initVelRnd: float = 0.1
export var angVel: float = 40.0
export var angVelRnd: float = 1.0
export var linAccl: float = 4
export var linAcclRnd: float = 1
export var angle: int = 360
export var angleRnd: float = 1.0
export var Pscale: float = 0.03
export var Pcolor: Color = Color("1624ef")
export var fireScale:Vector3 = Vector3(1,0.25,1)
export var life_Time:float = 0.13



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
	par = draw(par, aabb, localCords, drawOrder, life_Time)
	# Draw passes
	par = PdrawPasses(par, drawPasses, transparent, unshaded, useAlbedo, blendMode, meshMat, mesh)
	# material properties
	material = materialProperties(material, trailDivisor, emissionShape, direction, gravity, initVel, initVelRnd, angVel, angVelRnd, linAccl, linAcclRnd, angle, angleRnd, Pscale)
	material.scale_curve = curve as CurveTexture
	print(material.scale_curve)
	material.color = Pcolor
	material.color_ramp = colorRamp
	par.process_material = material
	par.amount = amount
	par.restart()
	var fire = Spatial.new()
	add_child(fire)
	fire.add_child(par)
	fire.translation = Vector3(0,0.191,0)
	fire.scale = fireScale
	print(curve)


func draw(par: Particles, pos: AABB, Cords: bool, dOrder: int, lifeTime: float):
	par.visibility_aabb = pos
	par.local_coords = Cords
	par.draw_order = dOrder
	par.lifetime = lifeTime
	return par

func PdrawPasses(par: Particles, dPasses: int, Ptransparent: bool, Punshaded: bool, PuseAlbedo: bool, PblendMode: int, meshMat: SpatialMaterial, mesh: QuadMesh):
	par.draw_passes = dPasses
	meshMat.flags_transparent = Ptransparent
	meshMat.flags_unshaded = Punshaded
	meshMat.vertex_color_use_as_albedo = PuseAlbedo
	meshMat.params_blend_mode = PblendMode
	mesh.material = meshMat
	par.draw_pass_1 = mesh
	return par
	
func materialProperties(material: ParticlesMaterial, PtrailDivisor: int, PemissionShape: int, Pdirection: Vector3, Pgravity: Vector3, PinitVel: float, PinitVelRnd: float, PangVel: float, PangVelRnd: float, PlinAccl: float, PlinAcclRnd: float, Pangle: int, PangleRnd: float, P_scale: float):
	material.trail_divisor = PtrailDivisor
	material.emission_shape = PemissionShape
	material.emission_sphere_radius = 0.01
	material.direction = Pdirection
	material.spread = 0.0
	material.gravity = Pgravity
	material.initial_velocity = PinitVel
	material.initial_velocity_random = PinitVelRnd
	material.angular_velocity = PangVel
	material.angular_velocity_random = PangVelRnd
	material.linear_accel = PlinAccl
	material.linear_accel_random = PlinAcclRnd
	material.angle = Pangle
	material.angle_random = PangleRnd 
	material.scale = P_scale
	material.scale_random = P_scale
	return material





		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
