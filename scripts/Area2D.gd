extends Area2D

var in_area = []
var tempo_list = []
var dir = 0
var mouve = [Vector2(0,16),Vector2(-16,0),Vector2(0,-16),Vector2(16,0)]
var iter = 1
var pause = true
var break_chain = false

@onready var centre_extraction = get_node("../Node2D/centre_d_extraction")

func _physics_process(delta):
	while in_area.size() != 0 and pause == false:
			pause = true
			for i in range(iter):
				position += mouve[dir]
				await get_tree().create_timer(0.05).timeout
				if in_area.size() == 0:
					break_chain = true
					break
			if break_chain == true:
				finish()
				break
			dir = 1
			for i in range(iter):
				position += mouve[dir]
				await get_tree().create_timer(0.05).timeout
				if in_area.size() == 0:
					break_chain = true
					break
			if break_chain == true:
				finish()
				break
			iter += 1
			dir = 2
			for i in range(iter):
				position += mouve[dir]
				await get_tree().create_timer(0.05).timeout
				if in_area.size() == 0:
					break_chain = true
					break
			if break_chain == true:
				finish()
				break
			dir = 3
			for i in range(iter):
				position += mouve[dir]
				await get_tree().create_timer(0.05).timeout
				if in_area.size() == 0:
					break_chain = true
					break
			if break_chain == true:
				finish()
				break
			dir = 0
			iter += 1
			pause = false

func _on_area_exited(area):
	in_area.resize(in_area.size()-1)

func _on_area_entered(area):
	in_area.append(0)

func finish():
	centre_extraction.asign = true
	centre_extraction.inst_pos = position
	position = Vector2(0,0)
	dir = 0
	iter = 1
