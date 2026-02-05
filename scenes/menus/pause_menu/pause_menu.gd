extends CanvasLayer
class_name PauseMenu

@onready var fov_slider: HSlider = get_node('HBoxContainer').get_node("FovSlider")
@onready var fov_label: Label = get_node('HBoxContainer').get_node('FovLabel')
@onready var camera: Camera3D = get_tree().get_first_node_in_group('camera')

func _ready() -> void:
	visible = false
	set_camera_field_of_view()
	connect_signals()


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
	camera.fov = value
	GameSettings.data['fov'] = value
	GameSettings.save_game()


func set_camera_field_of_view() -> void:
	GameSettings.load_game()
	fov_slider.value = GameSettings.data['fov']
	fov_label.text = str(GameSettings.data['fov'])


func connect_signals() -> void:
	connect('visibility_changed', pause_game)
	fov_slider.connect('value_changed', on_slider_value_changed)