extends Node2D

@onready var npc: CharacterBody2D = $NPCs/NPC

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#npc.train()
	#npc.store_model()
	if npc != null:
		npc.load_model()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://scenes/library1.tscn")
