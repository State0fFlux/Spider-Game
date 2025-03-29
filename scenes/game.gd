extends Node2D

const WIND_STRENGTH = 2.0
const DIST_SCALE = 0.01 # in inches

@onready var egg = $EggTrack
@onready var garbage = $GarbageCollector
@onready var wind = $Wind
@onready var howling = $Wind/Howling

func _ready() -> void:
	
	# Reset starting values
	Global.speed = 400
	Global.dist = 0
	Global.wind_direction = 1.0 * (-1 if randi_range(0,1) == 0 else 1)
	wind.position.x = -896 * Global.wind_direction
	Global.garbage = garbage

func _process(delta):
	# Handle distance accumulation
	Global.dist += Global.speed * delta * DIST_SCALE
	var tween = create_tween().set_parallel(true)
	# Handle wind gusts
	var input = Input.get_axis("rotate_left", "rotate_right")
	if input / Global.wind_direction > 0: # heavy gust goes in direction of wind
		#howling.pitch_scale = 1.5
		tween.tween_property(howling, "pitch_scale", 1.5, 1)
		Global.wind_strength = input * WIND_STRENGTH
	else:
		#howling.pitch_scale = 1
		tween.tween_property(howling, "pitch_scale", 1, 1)
		Global.wind_strength = 0

	for obstacle in get_tree().get_nodes_in_group("Obstacle"):
		obstacle.rotation += Global.wind_strength * delta
		
func tween_speed(speed) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(Global, "speed", speed, 5)

func _on_level_timer_timeout() -> void:
	tween_speed(1.5 * Global.speed)



func _on_wind_timer_timeout() -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(wind, "position", -wind.position, 2)
	tween.tween_property(Global, "wind_direction", -Global.wind_direction, 2)
