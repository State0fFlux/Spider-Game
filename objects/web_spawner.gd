extends Node2D

@onready var scene = preload("res://objects/web_obstacle.tscn")

func _ready() -> void:
	spawn_instance()

func spawn_instance():
	var instance = scene.instantiate()
	
	instance.self_speed = randf_range(-1,1)
	instance.base = randf_range(0.0, 2*PI)
	
	add_child(instance)


func _on_obstacle_timer_timeout() -> void:
	spawn_instance()
