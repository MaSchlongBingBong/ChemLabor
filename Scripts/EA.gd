extends Spatial



# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.open("res://Scripts/test.json", File.READ) != OK:
		return
	var data = file.get_as_text()
	var res = JSON.parse(data).result
	print(res["name"])

	for step in res["steps"]:
		print(step)
		pass

	spawnSphere(1, Vector3(1,0,0))
	spawnSphere(0.5, Vector3(1.5,1,0))
	spawnSphere(0.5, Vector3(1.5,-1,0))


func spawnSphere(radius: float, pos: Vector3):
	var mesh_node = MeshInstance.new()
	var sphere_mesh = SphereMesh.new()
	sphere_mesh.radius = radius
	sphere_mesh.height = radius*2
	mesh_node.mesh = sphere_mesh
	add_child(mesh_node)
	mesh_node.translation = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
