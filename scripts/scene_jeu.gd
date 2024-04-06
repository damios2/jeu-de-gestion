extends Node2D

var save_list = []
var save_line
var auto_save = true

var t = []

@onready var centre_extraction = $Node2D/centre_d_extraction

func _ready():
	var save = FileAccess.open("fichier_sauvegarde.save",FileAccess.READ)
	while save.get_length() > save.get_position():
		if save_list.size() < 2:
			save_list.append(save.get_line())
		else:
			var str_var = save.get_line()
			var json = JSON.new()
			var parse_res = json.parse(str_var)
			var rdata = json.get_data()
			var batiment = load(rdata["filename"]).instantiate()
			get_node("Node2D").add_child(batiment)
			batiment.position.x = rdata["pos_x"]
			batiment.position.y = rdata["pos_y"]
			batiment.add_to_group("save_group")
	save.close()
	centre_extraction.nb_uor = int(save_list[0])
	centre_extraction.nb_ror = int(save_list[1])

func _physics_process(delta):
	if auto_save == true:
		auto_save = false
		await get_tree().create_timer(3).timeout
		save_list = []
		save_list.append(centre_extraction.nb_uor)
		save_list.append(centre_extraction.nb_ror)
		for Node2D in get_tree().get_nodes_in_group("save_group"):
			Node2D.save_o = true
			await get_tree().create_timer(0.1).timeout
			var node_data = Node2D.save_dic
			save_list.append(node_data)
		var save = FileAccess.open("fichier_sauvegarde.save",FileAccess.WRITE)
		for i in range(save_list.size()):
			save_line = JSON.stringify(save_list[i])
			save.store_line(save_line)
		save.close()
		await get_tree().create_timer(20).timeout
		auto_save = true
