extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Array,NodePath) var sequenced_nodes

var disabledNodes = {}

var timer = 0

var reset_button

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(len(sequenced_nodes)):
		var node = get_node(sequenced_nodes[i])
		remove_child(node)
		disabledNodes[i] = node
	
	Global.Instance.connect("dataChange", self, "data_changed")


func _process(delta):
	timer += delta
	if(timer > 5 and timer < 10):
		for idx in disabledNodes:
			var node = disabledNodes[idx]
			add_child(node)
		timer = 20

func data_changed():
	reset_button = Global.Instance.data["reset_button"]
	if !reset_button.is_connected("pressed", self, "reset"):
		reset_button.connect("pressed", self, "reset")

func reset():
	print("RESETTING")
