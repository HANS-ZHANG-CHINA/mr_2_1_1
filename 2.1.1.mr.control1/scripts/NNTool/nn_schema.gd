extends Control

@onready var inputs: Control = $HBoxContainer/Inputs
@onready var outputs: Control = $HBoxContainer/Outputs



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func schema_factory(schema):
	inputs_factory(schema["inputs"], schema["inputs_arch"])
	outputs_factory(schema["outputs"], schema["outputs_arch"])
	
func inputs_factory(my_inputs, inputs_arch):
	inputs.schema_structure = inputs_arch
	for i in my_inputs:
		var new_label = Label.new()
		new_label.set_text(i)
		inputs.add_child_arch(new_label)
	
func outputs_factory(my_outputs, outputs_arch):
	outputs.schema_structure = outputs_arch
	for o in my_outputs:
		var new_label = Label.new()
		new_label.set_text(o)
		outputs.add_child_arch(new_label)
