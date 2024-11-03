extends Control
@onready var file_dialog: FileDialog = $FileDialog

var json_data = null
var change_data = null

var current_filename = null

@onready var nn_schema: Control = $HBoxContainer/VBoxContainer/PanelContainer2/NNSchema
@onready var example_data: VBoxContainer = $HBoxContainer/VBoxContainer/PanelContainer/ExampleData
@onready var l_example: Label = $HBoxContainer/VBoxContainer/HBoxContainer/LExample

@onready var button_save: Button = $HBoxContainer/VBoxContainer2/ButtonSave


var current_example = -1
var total_examples = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	example_data.data_changed.connect(example_data_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_tranning_data(filename):
	#var file = "res://data/action_selection_data.json"
	var json_as_text = FileAccess.get_file_as_string(filename)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		#print(json_as_dict)
		#return json_as_dict["data"]
		print("File opened")
		current_filename = filename
		return json_as_dict
	print("File Failed to open. filename: %s" %filename)

func save_tranning_data(filename):
	#var file = "res://data/action_selection_data.json"
	var file = FileAccess.open(filename,FileAccess.WRITE)
	
	var json_string = JSON.stringify(change_data)
	file.store_line(json_string)

func _on_button_pressed() -> void:
	example_data.clear_data()
	file_dialog.visible = true
	
func _on_button_save_pressed() -> void:
	save_tranning_data(current_filename)

func _on_file_dialog_file_selected(path: String) -> void:
	json_data = load_tranning_data(path)
	#nn_schema.schema_factory(json_data["schema"])
	change_data = json_data
	example_data.schema_factory_data(change_data["schema"], change_data["data"][0],
	 change_data, 0)
	total_examples = json_data["data"].size()
	print("Total examples: %s" % str(total_examples))
	current_example = 0
	l_example.set_text("Example %s" % str(current_example))

func _on_button_button_up() -> void:
	if current_example > 0:
		example_data.clear_data()
		current_example -= 1
		example_data.schema_factory_data(json_data["schema"], json_data["data"][current_example],
		change_data, current_example)
		l_example.set_text("Example %s" % str(current_example))
		


func _on_button_2_button_up() -> void:
	if current_example < total_examples-1:
		example_data.clear_data()
		current_example += 1
		example_data.schema_factory_data(json_data["schema"], json_data["data"][current_example],
		change_data, current_example)
		l_example.set_text("Example %s" % str(current_example))
		
func example_data_changed():
	button_save.visible = true
