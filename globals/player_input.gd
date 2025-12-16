extends Node
## Global encargado de tomar los inputs raw de el player y darles comportamientos

var _jump_buffer_timer: Timer

const BUTTONS: Dictionary = {
	"space": "space",
}


func _ready():
	_set_buffer_timer()
	
	
func jump_input_buffered(buffer_time: float = 0.2) -> bool:
	if Input.is_action_just_pressed(BUTTONS['space']):
		_jump_buffer_timer.start(buffer_time)
	
	return _jump_buffer_timer.time_left


func direction() -> Vector2:
	var dir := Input.get_vector("left", "right", "forward", "backward")
	return dir


func _set_buffer_timer() -> void:
	_jump_buffer_timer = Timer.new()
	add_child(_jump_buffer_timer)
	_jump_buffer_timer.autostart = false
	_jump_buffer_timer.one_shot = true
