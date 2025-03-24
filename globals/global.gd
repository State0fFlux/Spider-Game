extends Node

var speed = 400
var dist: int = 0

var wind_strength = 0.0
var wind_direction = 1.0

var on_bridge = false

@onready var garbage = $GarbageCollector

var mobile = false
