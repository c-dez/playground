extends Node
## Global encargado de tomar los inputs raw de el player y darles comportamientos

var _jump_buffer_timer: Timer
var _shift_buffer_timer: Timer

var can_move: bool = true

const BUTTONS: Dictionary = {
	"space": "space",
	"left_mb": "left_mb",
	"right_mb": "right_mb",
	"shift": "shift",
}


func _ready():
	_set_jump_buffer_timer()

# for debug
func _process(_delta: float) -> void:
	exit_game()
	
	
func jump_input_buffered(buffer_time: float = 0.2) -> bool:
	if Input.is_action_just_pressed(BUTTONS['space']):
		_jump_buffer_timer.start(buffer_time)
	
	return _jump_buffer_timer.time_left


func get_direction() -> Vector2:
	# var dir := Input.get_vector("left", "right", "forward", "backward")
	# return dir
	if can_move:
		return Input.get_vector("left", "right", "forward", "backward")
	else:
		return Vector2.ZERO


func left_mb() -> bool:
	return Input.is_action_just_pressed(BUTTONS["left_mb"])


func _set_jump_buffer_timer() -> void:
	_jump_buffer_timer = Timer.new()
	add_child(_jump_buffer_timer)
	_jump_buffer_timer.autostart = false
	_jump_buffer_timer.one_shot = true


func shift_buffer():
	_shift_buffer_timer = Timer.new()
	add_child(_shift_buffer_timer)
	####

func right_mb() -> bool:
	return Input.is_action_just_pressed(BUTTONS['right_mb'])

func exit_game()->void:
	if Input.is_action_just_pressed('exit'):
		get_tree().quit()