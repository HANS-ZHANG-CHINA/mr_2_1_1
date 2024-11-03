extends Node2D

@onready var engine: RigidBody2D = $MainRocket/Engine
@onready var main_rocket: RigidBody2D = $MainRocket



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_accept"):
		engine.set_amount_force(engine.max_thrust_force)
	else:
		engine.set_amount_force(0)
		
	if Input.is_action_pressed("ui_left"):
		main_rocket.apply_torque(-2000)
	if Input.is_action_pressed("ui_right"):
		main_rocket.apply_torque(2000)
