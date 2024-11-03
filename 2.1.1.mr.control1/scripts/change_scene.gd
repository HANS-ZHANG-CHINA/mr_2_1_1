extends Area2D

@export var next_level : String  = ""
@export var next_level_position : Vector2


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file(next_level)
		Meta.player_position = next_level_position
		Meta.player_health = body.health
