extends Spatial


var mol = {
	atoms = [
		{
			name = "Carbon",
			pos = {x=1, y=0, z=0},
			scale = 1
		},
		{
			name = "Carbon",
			pos = {x=-1, y=0, z=0},
			scale = 1
		},
		{
			name = "Hydrogen",
			pos = {x=1.5,y=1,z=0},
			scale=0.5
		},
		{
			name = "Hydrogen",
			pos = {x=1.5,y=-1,z=0},
			scale=0.5
		},
		{
			name = "Hydrogen",
			pos = {x=-1.5,y=1,z=0},
			scale=0.5
		},
		{
			name = "Hydrogen",
			pos = {x=-1.5,y=-1,z=0},
			scale=0.5
		}
	],
	bonds = [
		{
			from = 0,
			to = 1,
			count = 2
		}
	]
}

var atomObjects = []
var bondObjects = []
	

export(Dictionary) var atom_colors;

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.open("res://Scripts/test.json", File.READ) != OK:
		return
	var data = file.get_as_text()
	var res = JSON.parse(data).result
	print(res["name"])
	
	generate_molecule()


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

func generate_molecule():
	atomObjects = [];
	bondObjects = [];

	for child in get_children():
		child.queue_free()
	

	for i in range(len(mol["atoms"])):
		var atom = mol["atoms"][i];
		var ao = spawnSphere(atom.scale, Vector3(atom.pos.x,atom.pos.y,atom.pos.z))
		ao.name = atom.name + " [" + str(i) + "]";
		var m = SpatialMaterial.new()
		m.albedo_color = atom_colors.get(atom.name,Color("#ff00ff"))
		ao.set_surface_material(0,m)
		#get_child_of_type(ao,MeshInstance)
		#atomObjects[i] = ao;

	#foreach (Bond bond in bonds)
	# for (int b = 0; b < bonds.Length; b++)
	# {
	# 	Bond bond = bonds[b];
	# 	for (int i = 1; i <= bond.number; i++)
	# 	{
	# 		Atom from = atoms[bond.from];
	# 		Atom to = atoms[bond.to];
	# 		atoms[bond.from].AddBond(b);
	# 		atoms[bond.to].AddBond(b);
	# 		GameObject bo = Instantiate(bondObject);
	# 		bo.transform.SetParent(transform);
	# 		bo.name = from.name + " - " + to.name + " [" + b + "," + i + "]";
	# 		bo.transform.localPosition = bond.number > 1 ? from.pos + (new Vector3(0,0.1f * (i*2 - 3),0)) : from.pos;
	# 		//bo.transform.LookAt(to.pos + transform.position);
	# 		bo.transform.forward = atomObjects[bond.to].transform.position - atomObjects[bond.from].transform.position;
	# 		float dist = (to.pos - from.pos).magnitude/2;
	# 		float curr = 0.1f * (from.scale + to.scale)/2;
	# 		bo.transform.localScale = new Vector3(curr,curr,dist);
	# 		bo.GetComponentInChildren<MeshRenderer>().material = mats.GetValueOrDefault(to.name);
	# 		///TODO: will overwrite double bonds .... pls fix
	# 		bondObjects[b] = bo;
	# 	}
	# }

func spawnSphere(diameter: float, pos: Vector3):
	var collision_node = CollisionShape.new()
	var mesh_node = MeshInstance.new()
	var sphere_mesh = SphereMesh.new()
	sphere_mesh.radius = diameter/2
	sphere_mesh.height = diameter
	mesh_node.mesh = sphere_mesh
	var shape = SphereShape.new()
	shape.radius = diameter/2
	collision_node.shape = shape
	collision_node.add_child(mesh_node)
	add_child(collision_node)
	mesh_node.translation = pos
	return mesh_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
