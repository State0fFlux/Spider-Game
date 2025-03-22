extends Node2D

@onready var coin_scene = preload("res://objects/coin.tscn")

func spawn_instance(): # TODO: Fix spawning logic
	if randi_range(1,100) == 1: # probability spawning
		var coin_instance = coin_scene.instantiate()
		add_child(coin_instance)


func _on_coin_timer_timeout() -> void:
	spawn_instance()
