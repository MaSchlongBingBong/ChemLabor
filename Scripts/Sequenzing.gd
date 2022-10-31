extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Array,NodePath) var sequenced_nodes

var disabledNodes = {}

var saved_nodes = {}

var timer = 0

var reset_button

var seq = []
var step = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.open("res://Scripts/sequence.json", File.READ) != OK:
		return
	var data = file.get_as_text()
	var res = JSON.parse(data).result
	print(res["name"])
	seq = res.seq

	for node in range(len(sequenced_nodes)):
		saveNode(node)
		pass
	
	Global.Instance.connect("dataChange", self, "data_changed")

func loadNode(idx, data):
	var saved = saved_nodes[idx]
	if saved == null:
		return
	var current = get_node(sequenced_nodes[idx])
	current.queue_free()
	add_child(saved)
	sequenced_nodes[idx] = saved.get_path()
	if data.erase:
		saved_nodes.erase(idx)
	else:
		saved_nodes[idx] = saved.duplicate(7)

func saveNode(idx, _data = {}):
	var node = get_node(sequenced_nodes[idx])
	saved_nodes[idx] = node
	remove_child(node)
	var new_node = node.duplicate(7)
	add_child(new_node)
	

func _process(delta):
	timer -= delta
	if timer > 0 or step == -1:
		#print(step)
		return

	var current = seq[step]
	print("current step("+str(step)+") : " + str(current))
	var node = current.node
	if node == null:
		timer = current.data.time
	else:
		if has_method(current.function):
			call_deferred(current.function, current.node, current.data)
		else:
			printerr("function " + current.function + " not found")
	
	step += 1
	if step >= len(seq):
		step = -1

func data_changed():
	reset_button = Global.Instance.data["reset_button"]
	if !reset_button.is_connected("pressed", self, "reset"):
		reset_button.connect("pressed", self, "reset")

func reset():
	for idx in range(len(sequenced_nodes)):
		loadNode(idx,{erased = false})
