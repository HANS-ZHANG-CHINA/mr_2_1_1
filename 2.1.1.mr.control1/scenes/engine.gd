extends RigidBody2D

var thrust_force_length = 0
var max_thrust_force = 4000
var thrust_force = Vector2()

var fuel_second = 1.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_amount_force(amount: float):
	thrust_force_length = amount
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	var parent_transform = get_parent().transform
	
	#var direction_vector =  parent_transform * Vector2(0, 1) 
	var direction_vector =  Vector2(0, -1).rotated(get_parent().rotation)
	var displacement = Vector2(0,0)
	thrust_force = direction_vector.normalized() * thrust_force_length
	
	apply_force(thrust_force, displacement)
	#print(rad_to_deg(get_parent().rotation))
	#fuel -= power_fuel_drain * power
