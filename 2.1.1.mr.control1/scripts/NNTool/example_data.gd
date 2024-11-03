extends VBoxContainer

@onready var data_list_inputs: VBoxContainer = $DataListInputs
@onready var data_list_outputs: VBoxContainer = $DataListOutputs
const DATA_VALUE = preload("res://scenes/NNTool/data_value.tscn")

signal data_changed

var change_data = null
var current_example = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func schema_factory_data(schema, data, data_to_change, in_current_example):
	current_example = in_current_example
	inputs_factory(schema["inputs"], schema["inputs_arch"], data[0])
	outputs_factory(schema["outputs"], schema["outputs_arch"], data[1])
	change_data = data_to_change
func clear_data():
	for n in data_list_inputs.get_children():
		data_list_inputs.remove_child(n)
		n.queue_free()
	for n in data_list_outputs.get_children():
		data_list_outputs.remove_child(n)
		n.queue_free()
	data_list_inputs.reset_schema()
	data_list_outputs.reset_schema()

func inputs_factory(my_inputs, inputs_arch, data):
	if inputs_arch != null:
		data_list_inputs.schema_structure = inputs_arch
	var data_index = 0
	for i in my_inputs:
		var new_data_value = DATA_VALUE.instantiate()
		#if inputs_arch != null:
		new_data_value.value_changed.connect(example_data_value_changed)
		data_list_inputs.add_child_arch(new_data_value)
		new_data_value.setDataValuePair(i, data[data_index], data_index, 0)
		data_index += 1
		#new_label.set_text(i)
		
	
func outputs_factory(my_outputs, outputs_arch, data):
	if outputs_arch != null:
		data_list_outputs.schema_structure = outputs_arch
	var data_index = 0
	for o in my_outputs:
		var new_data_value = DATA_VALUE.instantiate()
		#if outputs_arch != null:
		new_data_value.value_changed.connect(example_data_value_changed)
		data_list_outputs.add_child_arch(new_data_value)
		new_data_value.setDataValuePair(o, data[data_index], data_index, 1)
		data_index += 1

func factory_data(schema, data):
	inputs_factory(schema["inputs"], null, data[0])
	outputs_factory(schema["outputs"], null, data[1])
	
func example_data_value_changed(new_value, index, in_or_out):
	change_data["data"][current_example][in_or_out][index] = new_value
	data_changed.emit()
