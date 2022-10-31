extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Array,NodePath) var sequenced_nodes

var disabledNodes = {}

var saved_nodes = {}

var timer = 0

var reset_button

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(len(sequenced_nodes)):
		save_props(i)
	
	Global.Instance.connect("dataChange", self, "data_changed")

func load_props(idx, erase: bool):
	var saved = saved_nodes[idx]
	if saved == null:
		return
	var current = get_node(sequenced_nodes[idx])
	current.queue_free()
	add_child(saved)
	sequenced_nodes[idx] = saved.get_path()
	if erase:
		saved_nodes.erase(idx)
	else:
		saved_nodes[idx] = saved.duplicate(7)

func save_props(idx):
	var node = get_node(sequenced_nodes[idx])
	saved_nodes[idx] = node
	remove_child(node)
	var new_node = node.duplicate(7)
	add_child(new_node)
	

func _process(_delta):
	pass

func data_changed():
	reset_button = Global.Instance.data["reset_button"]
	if !reset_button.is_connected("pressed", self, "reset"):
		reset_button.connect("pressed", self, "reset")

func reset():
	for idx in range(len(sequenced_nodes)):
		load_props(idx,false)
