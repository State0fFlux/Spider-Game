extends Node2D

@onready var obstacle_scene = preload("res://ring_obstacle.tscn")

func _ready() -> void:
	spawn_obstacle()

func _on_spawn_timer_timeout() -> void:
	spawn_obstacle()

func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	obstacle.global_position = global_position
	get_tree().current_scene.add_child(obstacle)
