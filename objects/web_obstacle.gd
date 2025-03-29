extends Node2D

@onready var bridge = $Bridge
@onready var webbing = $Polygon2D/WebNoise
@onready var area = $Area2D

var self_speed = 0.0
var base = 0.0
var displacement = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bridge.rotation = base
	displace()
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
		body.die()
		
# shifts the web's binding point & bridge location
func displace() -> void:
	var collider = get_node("Area2D/CollisionPolygon2D")
	var web = get_node("Polygon2D")
	var polygon: PackedVector2Array = collider.get_polygon()
	polygon[2].x = displacement
	polygon[5].x = displacement
	collider.set_polygon(polygon)
	web.set_polygon(polygon)
	bridge.position.x = displacement
