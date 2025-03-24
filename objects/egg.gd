extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= Global.speed * delta
	if global_position.y <= Global.garbage.global_position.y:
		queue_free()

func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Stats.eggs += 1
		queue_free()
