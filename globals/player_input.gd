extends Node
## Global encargado de tomar los inputs raw de el player y darles comportamientos

var jump_buffer_timer: Timer

func _ready():
	set_buffer_timer()
	
	
func jump_input_buffered(buffer_time: float = 0.2) -> bool:
	if Input.is_action_just_pressed('space'):
		jump_buffer_timer.start(buffer_time)
		pass
	
	return jump_buffer_timer.time_left


func set_buffer_timer() -> void:
	jump_buffer_timer = Timer.new()
	add_child(jump_buffer_timer)
	jump_buffer_timer.autostart = false
	jump_buffer_timer.one_shot = true