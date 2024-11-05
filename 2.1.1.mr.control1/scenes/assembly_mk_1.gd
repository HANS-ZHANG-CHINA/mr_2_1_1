extends Node2D

@onready var engine: RigidBody2D = $MainRocket/Engine
@onready var main_rocket: RigidBody2D = $MainRocket

@onready var ray_cast_2d: RayCast2D = $MainRocket/RayCast2D
@onready var neuron_component: NeuronComponent = $NeuronComponent

var distance_end_engine = 62.8
var distance_to_ground = 1000

var unit_distance = 1
var unit_velocity = 0

var auto_is_on:bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	neuron_component.set_input_weight_pair(unit_distance, 0)
	neuron_component.set_input_weight_pair(unit_velocity, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	ray_cast_2d.target_position = (main_rocket.position + Vector2(0, 1000)) * main_rocket.transform
	
	if Input.is_action_pressed("ui_accept"):
		engine.set_amount_force(engine.max_thrust_force)
		auto_is_on = false
	else:
		engine.set_amount_force(0)
		
	if Input.is_action_pressed("ui_left"):
		main_rocket.apply_torque(-2000)
	if Input.is_action_pressed("ui_right"):
		main_rocket.apply_torque(2000)
	
	if ray_cast_2d.is_colliding():
		var collision_point = ray_cast_2d.get_collision_point()
		distance_to_ground = collision_point.y - main_rocket.position.y - self.position.y - distance_end_engine
		#print(collision_point.y)
		#print(distance_to_ground)
		unit_distance = mapping_value_linear(distance_to_ground,0, 1000, 0, 1)
		
		neuron_component.set_input_value(0, unit_distance)
		
		var calc_linear_velocity_length = main_rocket.linear_velocity.length()
		unit_velocity = mapping_value_linear(clamp(calc_linear_velocity_length,0,1000),0, 1000, 0, 1)
		
		neuron_component.set_input_value(0, unit_velocity)
		#print(unit_distance)
		#print(unit_velocity)
		
		#print(main_rocket.linear_velocity.length())
		#print(self.position.y)
		#print( main_rocket.position.y - collision_point.y)
	if auto_is_on:
		engine.set_amount_force(engine.max_thrust_force * neuron_component.output_value)
		
func mapping_value_linear(input:float, min_input:float, max_input:float, min_value:float, max_value:float):
	return (input - min_value) / (max_input - min_input) * (max_value - min_value) + min_value
