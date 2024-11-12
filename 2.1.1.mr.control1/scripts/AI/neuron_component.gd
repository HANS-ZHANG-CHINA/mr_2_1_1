class_name NeuronComponent
extends Node

var input_weight_pair:Array
var soma_value = 0
var output_value = 0

var bias = 0.01

signal output_changed(new_value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_input_weight_pair(input, weight):
	input_weight_pair.append({'input': input, 'weight': weight})

func calculate_soma():
	soma_value = bias
	for i in input_weight_pair:
		soma_value += i["input"] * i["weight"]
		
func calculate_output():
	output_value = 0
	output_value = calculate_relu(soma_value)
	output_changed.emit(output_value)
	#print(output_value)
	
func calculate_relu(value) -> float:
	
	if value > 0:
		return value
		
	return 0


func set_input_value(index:int, value:float):
	if index > len(input_weight_pair):
		return -1
	
	input_weight_pair[index]["input"] = value
	calculate_soma()
	calculate_output()
	return 1
	
func set_weight_value(index:int, value:float):
	if index > len(input_weight_pair):
		return -1
	
	input_weight_pair[index]["weight"] = value
	calculate_soma()
	calculate_output()
	return 1
