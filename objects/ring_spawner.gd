extends Node2D

@onready var ring_scene = preload("res://objects/ring_obstacle.tscn")

func _ready() -> void:
	spawn_instance()

func spawn_instance():
	var ring_instance = ring_scene.instantiate()
	
	'''var new_speed = 0.0
	var i = randi_range(1,3)
	if i == 1: # low speed
		new_speed = randf_range(0.0,1.0)
	else: # high speed
		new_speed = randf_range(2.0, 3)
	if randi_range(1,2) == 1: # clockwise
			ring_instance.self_speed = new_speed
	else: # counter-clockwise
			ring_instance.self_speed = -new_speed'''
	ring_instance.self_speed = randf_range(-1,1)
	ring_instance.base = randf_range(0.0, 2*PI)
	
	add_child(ring_instance)


func _on_obstacle_timer_timeout() -> void:
	spawn_instance()
