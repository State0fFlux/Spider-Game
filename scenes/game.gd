extends Node2D

@onready var parallax = $Background/Parallax2D
@onready var coin_track = $CoinTrack
@onready var garbage = $GarbageCollector

func _ready() -> void:
	
	# Reset starting values
	Global.speed = 400
	parallax.autoscroll.y = -Global.speed
	Global.dist = 0
	Global.wind_strength = 0
	Global.garbage = garbage

func _process(delta):
	# Handle distance accumulation
	Global.dist += Global.speed * delta / 5
	Global.wind_strength = Input.get_axis("rotate_left", "rotate_right")
	if Global.wind_strength < 0 and not Global.wind_from_east or Global.wind_strength > 0 and Global.wind_from_east:
		Global.wind_strength = 0 # not possible for wind to blow here now!
	
	for obstacle in get_tree().get_nodes_in_group("Obstacle"):
		if Global.wind_strength != 0:
			obstacle.rotation += Global.wind_strength * 2 * delta
		
func tween_speed(speed) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(Global, "speed", speed, 5)
	tween.tween_property(parallax, "autoscroll", 1.5 * Vector2(0, -speed), 5)
	#Global.speed = speed
	#parallax.autoscroll.y = -speed

func _on_level_timer_timeout() -> void:
	tween_speed(1.5 * Global.speed)


func _on_wind_timer_timeout() -> void:
	Global.wind_from_east = not Global.wind_from_east
