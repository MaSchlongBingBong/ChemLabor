extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var mesh_node = MeshInstance.new()
	var sphere_mesh = SphereMesh.new()
	sphere_mesh.radius = 0.5
	sphere_mesh.height = 1
	mesh_node.mesh = sphere_mesh
	add_child(mesh_node)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
