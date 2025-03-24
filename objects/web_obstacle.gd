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
	
	bridge.rotation += self_speed * delta * Global.wind_direction

func _on_bridge_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		area.monitoring = false

func _on_bridge_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		area.monitoring = true

# Web detection
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().reload_current_scene()
