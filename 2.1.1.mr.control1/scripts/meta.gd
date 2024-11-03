extends Node

var player_position : Vector2 = Vector2(320, 141):
	get:
		return player_position
	set(value):
		player_position = value
		
var player_health : float = 100.0:
	get:
		return player_health
	set(value):
		player_health = value
