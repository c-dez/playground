extends CanvasLayer
class_name PauseMenu

@onready var fov_slider: HSlider = get_node('HBoxContainer').get_node("FovSlider")
@onready var fov_label: Label = get_node('HBoxContainer').get_node('FovLabel')


func _ready() -> void:
	visible = false
	connect('visibility_changed', pause_game)
	fov_slider.connect('value_changed', on_slider_value_changed)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('pause'):
		visible = !visible


func pause_game() -> void:
	if visible:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func on_slider_value_changed(value: int) -> void:
	fov_label.text = str(value)