extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= Global.speed * delta
	if global_position.y <= Global.garbage.global_position.y:
		queue_free()

func _on_collision_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		Stats.coins += 1
		queue_free()
