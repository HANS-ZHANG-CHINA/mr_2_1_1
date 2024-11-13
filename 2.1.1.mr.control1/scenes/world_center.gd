extends Node2D

@onready var assembly_mk_1: Node2D = $AssemblyMK1
@onready var altitude_h_slider: HSlider = $CanvasLayer/Panel/VBoxContainer/AltitudeWeight/AltitudeHSlider
@onready var velocity_h_slider: HSlider = $CanvasLayer/Panel/VBoxContainer/VelocityWeight/VelocityHSlider
@onready var label_2: Label = $CanvasLayer/Panel/VBoxContainer/Output/Label2

@onready var line_edit_altitude: LineEdit = $CanvasLayer/Panel/VBoxContainer/AltitudeWeight/LineEditAltitude
@onready var line_edit_velocity: LineEdit = $CanvasLayer/Panel/VBoxContainer/VelocityWeight/LineEditVelocity

@onready var texture_progress_bar: TextureProgressBar = $CanvasLayer/Panel2/TextureProgressBar
@onready var cb_use_fuel: CheckBox = $CanvasLayer/Panel/VBoxContainer/HBoxContainerUseFuel/CBUseFuel
@onready var panel_2: Panel = $CanvasLayer/Panel2

@onready var cb_randomize_altitude: CheckBox = $CanvasLayer/Panel/VBoxContainer/HBoxContainerRandomizeAltitude/CBRandomizeAltitude

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	altitude_h_slider.value = Meta.weight_altitude
	velocity_h_slider.value = Meta.weight_velocity
	assembly_mk_1.use_fuel = Meta.use_fuel
	cb_use_fuel.button_pressed = Meta.use_fuel
	assembly_mk_1.fuel = Meta.initial_fuel
	if Meta.use_fuel:
		panel_2.visible = true
	else:
		panel_2.visible = false
	
	cb_randomize_altitude.button_pressed = Meta.randomize_y
	if Meta.randomize_y:
		assembly_mk_1.position = Vector2(Meta.y_set.x, randf_range(-4000, -400))
	else:
		assembly_mk_1.position = Meta.y_set


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	line_edit_altitude.set_text("%2.2f"% assembly_mk_1.unit_distance)
	line_edit_velocity.set_text("%2.2f"% assembly_mk_1.unit_velocity)
	texture_progress_bar.value = assembly_mk_1.fuel_unit * 100

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_velocity_h_slider_value_changed(value: float) -> void:
	assembly_mk_1.neuron_component.set_weight_value(1, value)
	Meta.weight_velocity = value


func _on_altitude_h_slider_value_changed(value: float) -> void:
	assembly_mk_1.neuron_component.set_weight_value(0, value)
	Meta.weight_altitude = value


func _on_neuron_component_output_changed(new_value: Variant) -> void:
	label_2.set_text("%0.3f"%new_value)


func _on_cb_use_fuel_toggled(toggled_on: bool) -> void:
	assembly_mk_1.use_fuel = toggled_on
	Meta.use_fuel = toggled_on


func _on_cb_randomize_altitude_toggled(toggled_on: bool) -> void:
	Meta.randomize_y = toggled_on
