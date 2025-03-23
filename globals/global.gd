extends Node

var rotation_angle = 0.0
var speed = 400
var dist: int = 0

var drift_position = 0.0

@onready var garbage = $GarbageCollector

var mobile = false
