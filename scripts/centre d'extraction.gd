extends StaticBody2D

@onready var text_coin = get_parent().get_node("../CanvasLayer/Label")
var nb_uor = 0
var nb_ror = 0
var inst_pos = Vector2()
var asign = false

func _physics_process(delta):
	text_coin.text = str(nb_uor + nb_ror)

func _on_texture_button_pressed():
	get_parent().get_node("../Area2D").pause = false
	while not asign:
		await get_tree().create_timer(1).timeout
	asign = false
	var mine = load("res://scènes/mine_d_or.tscn").instantiate()
	get_parent().add_child(mine)
	mine.position = inst_pos
	mine.add_to_group("save_group")
