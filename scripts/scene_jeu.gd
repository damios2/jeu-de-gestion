extends Node2D

var save_list = []
var save_line
var auto_save = true

@onready var centre_extraction = $centre_d_extraction

func _ready():
	var save = FileAccess.open("fichier_sauvegarde.save",FileAccess.READ)
	while save.get_length() > save.get_position():
		save_list.append(save.get_line())
	save.close()
	centre_extraction.nb_uor = int(save_list[0])
	centre_extraction.nb_ror = int(save_list[1])

func _process(delta):
	if auto_save == true:
		auto_save = false
		await get_tree().create_timer(3).timeout
		save_list = []
		save_list.append(centre_extraction.nb_uor)
		save_list.append(centre_extraction.nb_ror)
		print(save_list)
		var save = FileAccess.open("fichier_sauvegarde.save",FileAccess.WRITE)
		for i in range(save_list.size()):
			save_line = JSON.stringify(save_list[i])
			save.store_line(save_line)
		save.close()
		await get_tree().create_timer(20).timeout
		auto_save = true

func _on_texture_button_pressed():
	$CanvasLayer/TextureButton.visible = false
