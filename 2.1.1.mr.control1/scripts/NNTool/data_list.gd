extends Control

var schema_structure = []

var current_row = 0
var current_collumn = 0
var max_collumn = -1
var current_horizon_node:HBoxContainer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func reset_schema():
	current_row = 0
	current_collumn = 0
	max_collumn = -1
	current_horizon_node = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_child_arch(my_node:Node):
	#var new_sb = StyleBoxFlat.new()
	#new_sb.bg_color = Color.RED
	#my_node.add_theme_stylebox_override("normal", new_sb)
	
	if current_collumn == 0:
		max_collumn = schema_structure[current_row]
		if max_collumn > 1:
			current_horizon_node = HBoxContainer.new()
			self.add_child(current_horizon_node)
			current_horizon_node.add_child(my_node)
			current_collumn += 1
		else:
			self.add_child(my_node)
			
	else:
		current_horizon_node.add_child(my_node)
		current_collumn += 1
		if current_collumn + 1 > max_collumn:
			current_collumn = 0
			max_collumn = -1
			current_row += 1
