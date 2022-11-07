extends Node

var Instance

var old_data = {}
var data = {}

signal dataChange

# Called when the node enters the scene tree for the first time.
func _ready():
	if Instance == null:
		Instance = self


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

static func lerpLiquid(mesh: MeshInstance, yStart: float, yEnd:float, weight: float):
	var Yscale = lerp(yStart, yEnd, weight)
	if mesh.scale.y > yEnd:
		mesh.scale.y = Yscale
	return mesh

static func loadScene(node: Node, scene:Resource):
	var instance = scene.instance()
	node.add_child(instance)
	return instance
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if old_data != data:
		emit_signal("dataChange")
		old_data = data

