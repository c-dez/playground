extends Node
class_name StateMachine
# old

var label: Label
@export var initial_state: State

var current_state: State = null
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)

	if initial_state:
		current_state = initial_state
		initial_state.enter()

	#
	label = get_node('Label')


func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)
	# print(current_state)


var debug_time := 0.0
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)

	var label_text = str(current_state)
	debug_time += delta
	if debug_time >= 0.5:
		label.text = label_text
		debug_time = 0


func on_child_transitioned(state: State, new_state_name: String):
	# confirma que la senal de el nodo state sea igual al current state
	if state != current_state:
		return

	var new_state = states[new_state_name.to_lower()]

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
