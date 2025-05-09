extends CharacterBody2D

const SPEED = 500

func _physics_process(delta: float) -> void:

	var hor_direction = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, hor_direction * SPEED, SPEED/20)
	var ver_direction = Input.get_axis("move_up", "move_down")
	velocity.y = move_toward(velocity.y, ver_direction * SPEED, SPEED/20)

	move_and_slide()

func die():
	if Global.dist > Stats.high_score:
		Stats.high_score = Global.dist
	Utils.saveGame()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
