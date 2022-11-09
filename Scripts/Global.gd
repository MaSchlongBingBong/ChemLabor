extends Node

var Instance

var old_data = {}
var data = {}

signal dataChange

var chemColors = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	if Instance == null:
		Instance = self
	var file = File.new()
	if file.open("res://Scripts/chemColor.json", File.READ) != OK:
		return
	var data = file.get_as_text()
	var res = JSON.parse(data).result
	for k in res:
		var v = res[k]
		var color = Color8(v[0], v[1], v[2])
		color.a = 0.8
		chemColors[k] = color



# Note: passing a value for the type parameter causes a crash
static func get_child_of_type(node: Node, child_type):
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		if child is child_type:
			return child


# Note: passing a value for the type parameter causes a crash
static func get_children_of_type(node: Node, child_type):
	var list = []
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		if child is child_type:
			list.append(child)
	return list

static func scaleLiquid(mesh: MeshInstance, target: float, speed: float):
	var start = mesh.get_meta("original_scale",-1)
	if start == -1:
		mesh.set_meta("original_scale",mesh.scale.y)
		start = mesh.scale.y
	var delta = (start-target) * speed
	if mesh.scale.y * sign(delta) > target * sign(delta):
		mesh.scale.y -= delta
		mesh.translation.y -= delta/2
		return true
	return false

static func lerpLiquid(mesh: MeshInstance, from: float, to: float, speed: float):
	var delta = (from-to) * speed
	if mesh.scale.y * sign(delta) > to * sign(delta):
		mesh.scale.y -= delta
		mesh.translation.y -= delta/2
		return true
	return false

static func isPointingDown(forward: Vector3, threshold = 0.1):
	return forward.normalized().dot(Vector3.DOWN) > threshold

static func loadScene(node: Node, scene:Resource):
	var instance = scene.instance()
	node.add_child(instance)
	return instance
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if old_data != data:
		emit_signal("dataChange")
		old_data = data

