extends Node2D

@onready var cam = $Camera2D
@onready var parallax = $Background/Parallax2D
@onready var window = $Camera2D/Window
@onready var coin_track = $CoinTrack
@onready var bg = $Background
@onready var text = $Player/RichTextLabel

@onready var garbage = $GarbageCollector

func _ready() -> void:
	
	# Reset starting values
	Global.speed = 400
	parallax.autoscroll.y = -Global.speed
	Global.dist = 0
	Global.rotation_angle = 0
	Global.drift_position = 0
	Global.garbage = garbage
	
	Input.use_accumulated_input = false
	if OS.get_name() in ["Android", "iOS"]:
		Global.mobile = true
	else:
		Global.mobile = false
		get_viewport().size = Vector2(1280,1280)

func _process(delta):
	# Handle distance accumulation
	Global.dist += Global.speed * delta / 5
	
	# Handle movement
	if Global.mobile:
		var grav = Input.get_gravity()
		
		# Handle mobile rotation
		var yaw = Vector2(grav.x, grav.y).normalized()
		Global.rotation_angle = PI/2 + atan2(yaw.y, yaw.x)
		cam.rotation = Global.rotation_angle
		
		# Handle mobile drift
		# TODO: FIGURE OUT HOW MOBILE DRIFT SHOULD WORK
		var pitch = asin((grav.rotated(Vector3(0,0,1), Global.rotation_angle)).z)
		
		text.text = str(grav) + " : " + str(pitch)
		
		Global.drift_position = Global.drift_position + pitch * 10
	else:
		# Handle computer rotation
		var change
		Global.rotation_angle += Input.get_axis("rotate_left", "rotate_right") * delta * 4 # for computer debugging
		window.rotation = Global.rotation_angle
		
		# Handle computer drift
		Global.drift_position = Global.drift_position + Input.get_axis("drift_left", "drift_right") * delta * 800
	
	for obstacle in get_tree().get_nodes_in_group("Obstacle"):
		obstacle.rotation = Global.rotation_angle
	
	Global.drift_position = clamp(Global.drift_position, -200, 200)
	coin_track.position.x = -Global.drift_position
	cam.position.x = -Global.drift_position
	bg.position.x = -Global.drift_position # TODO: fix after updating parallax sprite

func tween_speed(speed) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(Global, "speed", speed, 5)
	tween.tween_property(parallax, "autoscroll", 1.5 * Vector2(0, -speed), 5)
	#Global.speed = speed
	#parallax.autoscroll.y = -speed

func _on_level_timer_timeout() -> void:
	tween_speed(1.5 * Global.speed)
