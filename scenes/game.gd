extends Node2D

@onready var cam = $Camera2D
@onready var bg = $Background/Parallax2D
@onready var border = $Camera2D/Border

func _ready() -> void:
	Input.use_accumulated_input = false
	if OS.get_name() in ["Android", "iOS"]:
		Global.mobile = true
	else:
		Global.mobile = false
		get_viewport().size = Vector2(1280,1280)

func _process(delta):
	# Handles phone rotation
	if Global.mobile:
		var grav = Input.get_gravity()
		var scale = Vector2(grav.x, grav.y).normalized()
		Global.rotation_angle = PI/2 + atan2(scale.y, scale.x)
		cam.rotation = Global.rotation_angle
	else:
		var change = Input.get_axis("rotate_left", "rotate_right")
		Global.rotation_angle += change * delta * 4 # for computer debugging
		border.rotation = Global.rotation_angle
	
	for node in get_tree().get_nodes_in_group("Obstacle"):
		node.rotation = Global.rotation_angle

func set_speed(speed) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(Global, "speed", speed, 5)
	tween.tween_property(bg, "autoscroll", 1.5 * Vector2(0, -speed), 5)
	#Global.speed = speed
	#bg.autoscroll.y = -speed

func _on_level_timer_timeout() -> void:
	set_speed(Global.speed + Global.speed / 2)
