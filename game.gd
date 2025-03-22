extends Node2D
@onready var text = $RichTextLabel
@onready var obj = $Obj
@onready var cam = $Camera2D
@onready var bg = $Background

func _ready() -> void:
	Input.use_accumulated_input = false

func _process(delta):
	var gyro = Input.get_gyroscope()
	
	# Gyroscope gives rotation speed, so we integrate over time
	var delta_rotation = gyro.z * delta
	#Global.rotation_angle += delta_rotation  # Accumulate rotation over time

	text.text=str(Global.rotation_angle)
	rotation = Global.rotation_angle
	for node in get_tree().get_nodes_in_group("Obstacle"):
		node.rotation = -Global.rotation_angle


func _on_plus_pressed() -> void:
	Global.rotation_angle += PI/8

func _on_minus_pressed() -> void:
	Global.rotation_angle -= PI/8
