extends Node2D

var nb_or = 0
var grid_size = Vector2(16, 16)
var in_area = false
var ignore = false
var last_pos = Vector2()
var place = true
var ntemps = 0
var ltemps = 0

var test = true

@onready var cadrillage = get_node('../cadrillage')

func _ready():
	ntemps = int(Time.get_unix_time_from_system())

func _physics_process(delta):
	if Input.is_action_pressed("clic gauche") and in_area == true:
		ignore = true
		position = round(get_global_mouse_position() / grid_size) * grid_size
		cadrillage.visible = true
		test = true
	else:
		if place == false and ignore == true:
			position = last_pos
		if last_pos != position:
			last_pos = position
		ignore = false
		if test == true:
			cadrillage.visible = false
			test = false
	
	if (int(Time.get_unix_time_from_system()) - ntemps) % 60 == 0:
		nb_or += 10
		if nb_or > 100:
			$TextureButton.visible = true

func _on_area_2d_mouse_entered():
	if Input.is_action_pressed("clic gauche") == false:
		in_area = true

func _on_area_2d_mouse_exited():
	if ignore == false:
		in_area = false

func _on_area_2d_area_entered(area):
	place = false

func _on_area_2d_area_exited(area):
	place = true

func _on_texture_button_pressed():
	#get_node("../centre_d_extraction").nb_coin += nb_or
	nb_or = 0
	$TextureButton.visible = false
