extends Node2D

@onready var bridge = $Bridge
@onready var webbing = $Polygon2D/WebNoise
@onready var area = $Area2D

var self_speed = 0.0
var base = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bridge.rotation = base
	webbing.texture.noise.seed = randi_range(1,1000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= Global.speed * delta
	if global_position.y <= Global.garbage.global_position.y:
		queue_free()
	
	bridge.rotation += self_speed * delta * (-1.0 if Global.wind_from_east else 1.0)
	
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Player") and not Global.on_bridge:
			get_tree().reload_current_scene()
		pass
		
	
