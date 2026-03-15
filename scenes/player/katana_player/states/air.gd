extends State


# @onready var sm: StateMachine = get_parent()

var speed = 10

# var initial_height: float
var rotate_speed: float = 15

func enter() -> void:
	sm.parent.mesh.do_squash_and_stretch(1.2, 0.20)
	# initial_height = sm.parent.global_position.y
	# print('air')
	pass

func process(_delta: float) -> void:
	_change_state_to()


func physics_process(_delta: float) -> void:
	sm.parent.move(_delta, 1)
	# if Input.is_action_just_pressed('ground_pound'):
		# print('asdasd')


# func exit() -> void:
# 	sm.last_state = self


func _change_state_to() -> void:
	if sm.parent.is_on_floor():
		emit_signal('change_state_to', self , 'move')

	elif Input.is_action_just_pressed(PlayerInput.BUTTONS['shift']):
		emit_signal('change_state_to', self , 'groundpound')

	elif PlayerInput.light_attack_button():
		emit_signal('change_state_to', self , 'attack')


	if sm.last_state == sm.states['move']:
			# if Input.is_action_just_pressed('space'):
			if PlayerInput.jump_button():
				emit_signal('change_state_to', self , 'kick')

	elif sm.last_state == sm.states['wallkick']:
		# if Input.is_action_just_pressed('space'):
		if PlayerInput.jump_button():
			emit_signal('change_state_to', self , 'kick')

	elif sm.last_state == sm.states['groundpoundonfloor']:
		# if Input.is_action_just_pressed('space'):
		if PlayerInput.jump_button():
			emit_signal('change_state_to', self , 'kick')
		

	pass
