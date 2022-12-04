extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Array,NodePath) var sequenced_nodes

var disabledNodes = {}

var reset_nodes = {}
var save_nodes = {}
var playing_audios = {}

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
	Global.data["sequence"] = self

	seq_save(reset_nodes)

func seq_load(save_array):
	for i in range(len(save_array)):
		var current = get_node(sequenced_nodes[i])
		var saved = save_array[i]
		if current == null or saved == null:
			continue
		current.queue_free()
		add_child(saved)
		sequenced_nodes[i] = saved.get_path()
		save_array[i] = saved.duplicate(7)

func seq_save(save_array):
	for i in range(len(sequenced_nodes)):
		var node = get_node(sequenced_nodes[i])
		if node == null:
			continue
		var copy = node.duplicate(7)
		save_array[i] = copy
	

func playAudio(idx, data):
	var node = get_tree().get_nodes_in_group("AudioPlayer")[0]
	var audio = node.get_child(idx)
	if audio:
		audio.play(data.pos)
		playing_audios[idx] = {pos = data.pos, duration = data.duration, node = audio}

func checkAudio(idx):
	var data = playing_audios[idx]
	if data:
		if data.node.get_playback_position() > data.pos + data.duration:
			data.node.stop()

func _process(delta):
	for idx in playing_audios:
		checkAudio(idx)
	timer -= delta
	if timer > 0 or step == -1:
		#print(step)
		return

	var current = seq[step]
	print("current step("+str(step)+") : " + str(current))
	match current.function:
		"Nop":
			timer = current.data.time
		"Save":
			seq_save(save_nodes)
		"Load":
			seq_load(save_nodes)
		"PlayAudio":
			var node = get_tree().get_nodes_in_group("AudioPlayer")[0]
			var audio = node.get_child(current.data.idx)
			if audio:
				audio.play(current.data.pos)
				playing_audios[current.data.idx] = {pos = current.data.pos, duration = current.data.duration, node = audio}
		_: 
			print("function " + current.function + " not found")
	
	step += 1
	if step >= len(seq):
		step = -1

func reset():
	seq_load(reset_nodes)


func _on_loadButton_pressed():
	seq_load(save_nodes)
	pass # Replace with function body.
