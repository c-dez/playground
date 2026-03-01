extends Node
## Global encargado de tomar los inputs raw de el player y darles comportamientos

var _jump_buffer_timer: Timer
# var _shift_buffer_timer: Timer

var can_move: bool = true

const BUTTONS: Dictionary = {
	"shift": "shift",

	"heavy_attack": "heavy_attack",
	"light_attack": "light_attack",
	"jump": 'space',
}


func _ready():
	_set_jump_buffer_timer()

# for debug
# var fps_time:float = 1.0
func _process(_delta: float) -> void:
	exit_game()


	# fps_time += _delta
	# if fps_time >= 1.0:
	# 	fps_time = 0.0
	# 	print("FPS:", Engine.get_frames_per_second())
	pass

func _input(event):
	if event.is_action_pressed("e_key"):
		var mode = DisplayServer.window_get_mode()
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	
func jump_input_buffered(buffer_time: float = 0.2) -> bool:
	if Input.is_action_just_pressed(BUTTONS['jump']):
		_jump_buffer_timer.start(buffer_time)
	
	return _jump_buffer_timer.time_left


## space/L2
func jump_button() -> bool:
	return Input.is_action_just_pressed(BUTTONS['jump'])

func get_direction() -> Vector2:
	
	if can_move:
		return Input.get_vector("left", "right", "forward", "backward")
	else:
		return Vector2.ZERO



## left_muse/ R1
func light_attack_button() -> bool:
	return Input.is_action_just_pressed(BUTTONS['light_attack'])


## right_mouse/R2
func heavy_attack_button() -> bool:
	return Input.is_action_just_pressed(BUTTONS["heavy_attack"])


func exit_game() -> void:
	if Input.is_action_just_pressed('exit'):
		get_tree().quit()


func _set_jump_buffer_timer() -> void:
	_jump_buffer_timer = Timer.new()
	add_child(_jump_buffer_timer)
	_jump_buffer_timer.autostart = false
	_jump_buffer_timer.one_shot = true