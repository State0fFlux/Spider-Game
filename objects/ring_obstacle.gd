extends Node2D

@onready var ring = $Ring

var self_speed = 0.0
var base = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ring.rotation = base


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= Global.speed * delta
	ring.rotation += self_speed * delta
