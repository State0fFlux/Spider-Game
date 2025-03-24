extends Node

var speed = 400
var dist: float = 0 # in inches

var wind_strength = 0.0
var wind_direction = 1.0

var on_bridge = false

@onready var garbage

var mobile = false

func num_format(number : int) -> String:
	return str(number)
	'''
	if number < 1000:
		return str(number)
	elif number < 1000000:
		return str(snapped(float(number) / 1000, 0.1)) + "k"
	else:
		return "LOL HOW DID YOU EVEN EARN THIS MUCH?"
	'''
