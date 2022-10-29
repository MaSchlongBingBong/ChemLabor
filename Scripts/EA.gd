extends "res://addons/godot-xr-tools/objects/pickable.gd"


var mol = {}
var steps = {}

var atomObjects = []
var bondObjects = []
var currentMoveableAtom = {}

var currIndex = -1
var counter = 0
var currTimeout = 0

export(Dictionary) var atom_colors;

# Called when the node enters the scene tree for the first time.
func _ready():
	loadMolecule()
	generate_molecule()
	playAnim()

func action():
	playAnim()

func loadMolecule():
	var file = File.new()
	if file.open("res://Scripts/test.json", File.READ) != OK:
		return
	var data = file.get_as_text()
	var res = JSON.parse(data).result
	print(res["name"])
	mol = res.mol
	steps = res.steps

func playAnim():
	loadMolecule()
	generate_molecule()
	currIndex = 0


func nextAnimStep(delta):
	if currIndex == -1:
		return
	counter += delta;

	if counter < currTimeout:
		return

	var step = steps[currIndex]
	match step.type:
		"Nop":
			pass
		"createBond":
			mol.bonds.append({from=step.data.from, to=step.data.to, number=step.data.get("number",1)})
			generate_molecule()
		"deleteBond":
			var bond = mol.bonds[step.data.idx]
			if bond.number > 1:
				mol.bonds[step.data.idx].number -= 1
			else:
				mol.bonds.remove(step.data.idx)
			generate_molecule()
		"playAudio":
				print("playing audio once implemented lol")
		"moveAtom":
				moveAtom(step.data.idx, dict2vec(step.data.pos), step.duration)
		_:
			printerr("type '" + step.type + "' unknown")
		
	counter = 0;
	currTimeout = step.duration;
	currIndex += 1;
	print(currIndex);
	if currIndex >= len(steps):
		currIndex = -1;


func nextDrawStep(delta):
	if !currentMoveableAtom.empty():
		currentMoveableAtom.timer += delta;
		# Move Atom
		currentMoveableAtom.atomObject.translation = lerp(currentMoveableAtom.from, currentMoveableAtom.to, currentMoveableAtom.timer/currentMoveableAtom.time);
		
		#Move Bonds
		for i in currentMoveableAtom.atom.bonds:
			var bo = bondObjects[i]
			var bond = mol.bonds[i]
			var from = mol.atoms[bond.from];
			var dist = (atomObjects[bond.to].translation - atomObjects[bond.from].translation).length();
			var trans = dict2vec(from.pos)
			bo.translation = trans
			var dir = atomObjects[bond.to].global_translation - bo.global_translation
			if Vector3.UP.cross(dir) != Vector3():
				bo.look_at(atomObjects[bond.to].global_translation, Vector3.UP);
			else:
				bo.rotate_x(sign(dir.y) * PI/2)
			if bond.number > 1:
				trans = trans + (Vector3(0,0.1 * ((i+1)*2 - 3),0))
			bo.translation = trans

			bo.translate(Vector3(0,0,-dist/2));
			bo.rotate_object_local(Vector3(1,0,0),PI/2)

			bo.shape.height = dist
			get_child_of_type(bo,MeshInstance).mesh.height = dist
			

		if currentMoveableAtom.timer >= currentMoveableAtom.time:
			currentMoveableAtom = {}
			generate_molecule()

func _process(delta):
	print(self.scale)
	self.get_pat
	nextDrawStep(delta)
	nextAnimStep(delta)
	

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

func moveAtom(atomIndex: int, pos: Vector3, time: float):
	var atom = mol.atoms[atomIndex];
	var bonds =  [];
	for idx in atom.bonds:
		bonds.append(bondObjects[idx]);

	currentMoveableAtom = {
		atom = atom,
		from = dict2vec(atom.pos),
		to = pos,
		time = time,
		timer = 0,
		atomObject = atomObjects[atomIndex],
	};

	mol.atoms[atomIndex].pos = pos;

func generate_molecule():
	atomObjects = [];
	atomObjects.resize(len(mol.atoms))
	bondObjects = [];
	bondObjects.resize(len(mol.bonds))

	for child in get_children_of_type(self,CollisionShape):
		child.queue_free()
	

	for i in range(len(mol["atoms"])):
		var atom = mol["atoms"][i];
		mol.atoms[i]["bonds"] = []
		var ao = spawnSphere(atom.scale, Vector3(atom.pos.x,atom.pos.y,atom.pos.z))
		ao.name = atom.name + " [" + str(i) + "]";
		var m = SpatialMaterial.new()
		m.albedo_color = atom_colors.get(atom.name,Color("#ff00ff"))
		get_child_of_type(ao,MeshInstance).set_surface_material(0,m)
		atomObjects[i] = ao;

	for b in range(len(mol.bonds)):
		var bond = mol.bonds[b];
		for i in range(bond.number):
			var from = mol.atoms[bond.from];
			var to = mol.atoms[bond.to];
			mol.atoms[bond.from].bonds.append(b);
			mol.atoms[bond.to].bonds.append(b);
			var curr = 0.1 * (from.scale + to.scale)/2;
			var dist = (dict2vec(to.pos) - dict2vec(from.pos)).length();
			var bo = spawnCylinder(curr,dist)
			bo.name = from.name + " - " + to.name + " [" + str(b) + "," + str(i) + "]";
			#bo.transform.localPosition = bond.number > 1 ? from.pos + (new Vector3(0,0.1f * (i*2 - 3),0)) : from.pos;
			var trans = dict2vec(from.pos)
			bo.translation = trans
			var dir = atomObjects[bond.to].global_translation - bo.global_translation
			if Vector3.UP.cross(dir) != Vector3():
				bo.look_at(atomObjects[bond.to].global_translation, Vector3.UP);
			else:
				bo.rotate_x(sign(dir.y) * PI/2)
			if bond.number > 1:
				trans = trans + (Vector3(0,0.1 * ((i+1)*2 - 3),0))
			bo.translation = trans

			bo.translate(Vector3(0,0,-dist/2));
			bo.rotate_object_local(Vector3(1,0,0),PI/2)

			var m = SpatialMaterial.new()
			m.albedo_color = atom_colors.get(to.name,Color("#ff00ff"))
			get_child_of_type(bo,MeshInstance).set_surface_material(0,m)
			# ///TODO: will overwrite double bonds .... pls fix
			bondObjects[b] = bo;

func dict2vec(dict):
	return Vector3(dict.x,dict.y,dict.z)

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
	collision_node.translation = pos
	return collision_node

func spawnCylinder(radius, length):
	var collision_node = CollisionShape.new()
	var mesh_node = MeshInstance.new()
	var cylinder_mesh = CylinderMesh.new()
	cylinder_mesh.top_radius = radius
	cylinder_mesh.bottom_radius = radius
	cylinder_mesh.height = length
	mesh_node.mesh = cylinder_mesh
	var shape = CylinderShape.new()
	shape.radius = radius
	shape.height = length
	collision_node.shape = shape
	collision_node.add_child(mesh_node)
	add_child(collision_node)
	return collision_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
