extends StaticBody2D

@onready var text_coin = get_node("../CanvasLayer/Label")
var nb_coin = 0

func _process(delta):
	text_coin.text = str(nb_coin)
