extends Node

var weight_altitude : float = 0.0:
	get:
		return weight_altitude
	set(value):
		weight_altitude = value
		
var weight_velocity : float = 0.0:
	get:
		return weight_velocity
	set(value):
		weight_velocity = value
		
var use_fuel = false

var randomize_y = false
var y_set = Vector2(535,-500)

var initial_fuel = 10000.0
