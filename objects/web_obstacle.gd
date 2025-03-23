extends Node2D

@onready var self_ring = $Polygon2D/Ring/SelfRing

var self_speed = 0.0
var base = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self_ring.rotation = base


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(position)
	position.y -= Global.speed * delta
	if global_position.y <= Global.garbage.global_position.y:
		queue_free()
	
	self_ring.rotation += self_speed * delta
