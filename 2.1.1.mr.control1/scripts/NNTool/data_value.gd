extends VBoxContainer

@onready var data_name: Label = $DataName
@onready var data_value: LineEdit = $DataValue

signal value_changed(new_value, index, in_or_out)
var my_value = null
var index_data = -1
var input_or_output = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setDataValuePair(set_name:String, set_value:float, in_index, in_or_out):
	index_data = in_index
	input_or_output = in_or_out
	data_name.set_text(set_name)
	data_value.set_text(str(set_value))
	my_value = set_value


func _on_data_value_text_submitted(new_text: String) -> void:
	data_value.add_theme_color_override("font_color", Color.AQUA)
	my_value = float(data_value.text)
	value_changed.emit(my_value, index_data, input_or_output)
