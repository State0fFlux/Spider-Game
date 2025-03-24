extends Node2D

@onready var egg_scene = preload("res://objects/egg.tscn")

func spawn_instance(): # TODO: Fix spawning logic
	if randi_range(1,3) == 1: # probability spawning
		var egg_instance = egg_scene.instantiate()
		add_child(egg_instance)


func _on_egg_timer_timeout() -> void:
	spawn_instance()
