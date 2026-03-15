extends State

# @onready var sm: StateMachine = get_parent()

func enter() -> void:
	# print(name)
	if sm.last_state == sm.states['air']:
		sm.parent.mesh.do_squash_and_stretch(0.7, 0.10)
	pass
	

func process(_delta: float) -> void:
	_change_state_to()


func physics_process(_delta: float) -> void:
	sm.parent.move(_delta, 1)

# func exit() -> void:
# 	sm.last_state = self


func _change_state_to() -> void:
	if !sm.parent.is_on_floor() and sm.parent.can_jump == false:
		emit_signal('change_state_to', self , 'air')
	
	# elif Input.is_action_just_pressed(PlayerInput.BUTTONS['shift']):
	elif PlayerInput.shitf_button():
		emit_signal('change_state_to', self , 'slide')
	
	elif PlayerInput.light_attack_button():
		emit_signal('change_state_to', self , 'attack')

		pass
