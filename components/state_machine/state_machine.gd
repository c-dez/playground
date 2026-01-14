extends Node
class_name StateMachine

var initial_state: State
@onready var parent:Enemy = get_parent()
var current_state: State = null
var states: Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.change_state_to.connect(on_state_change)
	if initial_state:
		current_state = initial_state
		initial_state.enter()
	
	


func _process(_delta: float) -> void:
	current_state.process(_delta)
	# print(current_state)
	pass


func _physics_process(_delta: float) -> void:
	current_state.physics_process(_delta)
	pass


func on_state_change(_current_state: State, new_state_string: String) -> void:
	if _current_state != current_state:
		printerr(self.name,' on_state_change(): current_state doesnt match')
		return

	var new_state = states[new_state_string.to_lower()]
	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
	pass