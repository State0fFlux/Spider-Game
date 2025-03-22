extends Node2D
@onready var text = $RichTextLabel
@onready var obj = $Obj
@onready var cam = $Camera2D
@onready var bg = $Background

var rotation_angle = 0.0  # Store filtered value

func _ready() -> void:
	Input.use_accumulated_input = false

func _process(delta):
	var gyro = Input.get_gyroscope()
	
	# Gyroscope gives rotation speed, so we integrate over time
	var delta_rotation = gyro.z * delta
	rotation_angle += delta_rotation  # Accumulate rotation over time

	text.text=str(rotation_angle)
	cam.rotation = rotation_angle
	bg.rotation = rotation_angle
	obj.rotation = rotation_angle
	for node in get_tree().get_nodes_in_group("Obstacle"):
		node.rotation = rotation_angle
