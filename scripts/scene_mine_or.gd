extends Node2D

var nb_or = 0
var grid_size = Vector2(16, 16)
var in_area = false
var ignore = false
var last_pos = Vector2()
var place = true
var ntemps = 0
var ltemps = 0
var production = true
var allow_cad = true
var anim = true
var save_o = false
var save_dic = {}

@onready var cadrillage = get_parent().get_node('../cadrillage')

func _ready():
	$StaticBody2D/AnimatedSprite2D.play("default")
	last_pos = position

func _physics_process(delta):
	if Input.is_action_pressed("clic gauche") and in_area == true:
		ignore = true
		position = round(get_global_mouse_position() / grid_size) * grid_size
		cadrillage.visible = true
		allow_cad = true
	else:
		if place == false and ignore == true:
			position = last_pos
		ignore = false
		if allow_cad == true:
			cadrillage.visible = false
			allow_cad = false
		if last_pos != position:
			last_pos = position
	
	if production == true:
		production = false
		nb_or += 10
		if nb_or > 100:
			$TextureButton.visible = true
		await get_tree().create_timer(1).timeout
		production = true
	
	if anim == true:
		anim = false
		$StaticBody2D/AnimatedSprite2D.play("default")
		await get_tree().create_timer(randf_range(0,15)).timeout
		anim = true
	
	if save_o == true:
		save_dic = save()

func _on_area_2d_mouse_entered():
	if Input.is_action_pressed("clic gauche") == false:
		in_area = true

func _on_area_2d_mouse_exited():
	if ignore == false:
		in_area = false

func _on_area_2d_area_entered(area):
	if area.collision_mask == 3:
		place = false
		await get_tree().create_timer(0.05).timeout
		place = false

func _on_area_2d_area_exited(area):
	if area.collision_mask == 3:
		place = true

func _on_texture_button_pressed():
	get_node("../centre_d_extraction").nb_uor += nb_or
	nb_or = 0
	$TextureButton.visible = false

func save():
	var save_dic = {
	"filename" : get_scene_file_path(),
	"pos_x" : position.x,
	"pos_y" : position.y
	}
	return save_dic
