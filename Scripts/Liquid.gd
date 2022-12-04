extends "res://addons/godot-xr-tools/objects/pickable.gd"

var liquid
var flow = 0

export var volume = 0
export var chemical_name = ""
export var emptyScale = 0.002
export var fullScale = 0.05
export var emptyRate = 1
export var fillVolume = 50

func _ready():
	liquid = $Liquid
	$Particles.emitting = false
	setName(chemical_name)
	calcLiquid()

func setName(name):
	chemical_name = name
	liquid.get_active_material(0).albedo_color = Global.chemColors.get(name,Color(1,0,1,1))
	liquid.visible = true
	if name == "":
		liquid.visible = false

func fill(vol, chemName):
	if self.chemical_name == "" or self.chemical_name == chemName:
		volume += vol
		if volume > fillVolume:
			volume = fillVolume
		calcLiquid()
		setName(chemName)
	else:
		# DO THE MIXING IN HERE BRO !
		print("mixing " + self.chemical_name + " and " + chemName + " together doesn't work, voiding " + chemName)
		reaction(self.chemical_name, chemName)


func reaction(chemName, chemName2):
	print("reaction starting")
	if chemName == "Silbernitrate" and chemName2 == "Dibromethan":
		# idk make chem1 more blurry?
		print("Shit is shitting")

 
func empty(vol):
	volume -= vol
	calcLiquid()
	if volume < 0:
		volume = 0
		setName("")
		return

	var particles = $Particles
	#particles.process_material.direction = self.linear_velocity*10 + Vector3.UP
	particles.process_material.color = liquid.get_active_material(0).albedo_color
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(particles.global_translation,particles.global_translation + Vector3.DOWN)
	var collider = result.get("collider")
	if collider == null:
		return
	if(collider.has_method("fill")):
		collider.call("fill",vol, chemical_name)


func calcLiquid():
	var target = lerp(emptyScale, fullScale, volume/fillVolume)
	var delta = target - liquid.scale.y
	liquid.scale.y += delta
	liquid.translation.y += delta/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var downness = self.transform.basis.y.dot(Vector3.DOWN)
	var shouldFlow = downness > 0.2
	shouldFlow = shouldFlow and volume > 0
	#$Particles.emitting = flowing
	if shouldFlow:
		empty(delta * downness * emptyRate)
		$Particles.emitting = true
	else:
		$Particles.emitting = false
