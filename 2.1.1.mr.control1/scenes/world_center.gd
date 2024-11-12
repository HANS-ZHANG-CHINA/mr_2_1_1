extends Node2D

@onready var assembly_mk_1: Node2D = $AssemblyMK1
@onready var altitude_h_slider: HSlider = $CanvasLayer/Panel/VBoxContainer/AltitudeWeight/AltitudeHSlider
@onready var velocity_h_slider: HSlider = $CanvasLayer/Panel/VBoxContainer/VelocityWeight/VelocityHSlider
@onready var label_2: Label = $CanvasLayer/Panel/VBoxContainer/Output/Label2

@onready var line_edit_altitude: LineEdit = $CanvasLayer/Panel/VBoxContainer/AltitudeWeight/LineEditAltitude
@onready var line_edit_velocity: LineEdit = $CanvasLayer/Panel/VBoxContainer/VelocityWeight/LineEditVelocity


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	altitude_h_slider.value = Meta.weight_altitude
	velocity_h_slider.value = Meta.weight_velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	line_edit_altitude.set_text("%2.2f"% assembly_mk_1.unit_distance)
	line_edit_velocity.set_text("%2.2f"% assembly_mk_1.unit_velocity)

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
