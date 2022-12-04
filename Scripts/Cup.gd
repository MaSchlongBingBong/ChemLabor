extends "res://addons/godot-xr-tools/objects/pickable.gd"

var liquid
var empty = true
var flowing = false
var volume = 0
var deltaVolume = 0
var chemical_name = ""

var emptyLevel = 0.002
var fullLevel = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	liquid = $Liquid
	deltaVolume = abs(emptyLevel - fullLevel)

func setName(name):
	chemical_name = name
	liquid.get_active_material(0).albedo_color = Global.chemColors.get(name,Color(1,0,1,1))
	liquid.visible = true
	if name == "":
		liquid.visible = false

func fill(speed, chemName):
	if self.chemical_name == "" or self.chemical_name == chemName:
		Global.lerpLiquid(liquid, emptyLevel, fullLevel , speed)
		empty = false
		setName(chemName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var downness = self.transform.basis.y.dot(Vector3.DOWN)
	flowing = downness > 0.2
	flowing = flowing and not empty
	#$Particles.emitting = flowing
	if flowing:
		print(flowing)
		empty = !Global.lerpLiquid(liquid, fullLevel, emptyLevel, delta * downness)
		if empty:
			setName("")

