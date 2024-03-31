extends Node2D

var ignore = false
var in_area = false
var place = true
var last_pos = Vector2()
var grid_size = Vector2(16,16)
var allow_cad = true
var nb_or = 0
var prod = true

@onready var cadrillage = get_parent().get_node('../cadrillage')

func _ready():
	$StaticBody2D/AnimatedSprite2D.play("default")

func _physics_process(delta):
	if Input.is_action_pressed("clic gauche") and in_area == true:
		ignore = true
		position = round(get_global_mouse_position() / grid_size) * grid_size
		cadrillage.visible = true
		allow_cad = true
	else:
		if place == false and ignore == true:
			position = last_pos
		if last_pos != position:
			last_pos = position
		ignore = false
		if allow_cad == true:
			cadrillage.visible = false
			allow_cad = false
	
	if prod == true and get_node("../centre_d_extraction").nb_uor >= 10:
		prod = false
		get_node("../centre_d_extraction").nb_uor -= 10
		get_node("../centre_d_extraction").nb_ror += 12
		await get_tree().create_timer(10).timeout
		prod = true

func _on_area_2d_mouse_entered():
	if Input.is_action_pressed("clic gauche") == false:
		in_area = true

func _on_area_2d_mouse_exited():
	if ignore == false:
		in_area = false

func _on_area_2d_area_entered(area):
	await get_tree().create_timer(0.1).timeout
	place = false

func _on_area_2d_area_exited(area):
	place = true
