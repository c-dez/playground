extends State


@onready var sm: StateMachine = get_parent()

var speed = 10

# var initial_height: float
var rotate_speed: float = 15

func enter() -> void:
	sm.parent.mesh.do_squash_and_stretch(1.2, 0.20)
	# initial_height = sm.parent.global_position.y
	print('air')
	pass


func physics_process(_delta: float) -> void:
	_change_state_to()
	move(_delta)


func exit() -> void:
	sm.last_state = self


func move(delta) -> void:
	var input_dir := PlayerInput.get_direction()
	var direction := (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		sm.parent.velocity.x = direction.x * speed
		sm.parent.velocity.z = direction.z * speed

		sm.parent.rotate_mesh(direction, delta, rotate_speed)
	else:
		sm.parent.velocity.x = move_toward(sm.parent.velocity.x, 0, speed)
		sm.parent.velocity.z = move_toward(sm.parent.velocity.z, 0, speed)


func _change_state_to() -> void:
	if sm.parent.is_on_floor():
		emit_signal('change_state_to', self, 'move')
	
	elif sm.last_state == sm.states['move']:
			if Input.is_action_just_pressed('space'):
				emit_signal('change_state_to', self, 'kick')
	elif sm.last_state == sm.states['wallkick']:
		if Input.is_action_just_pressed('space'):
				emit_signal('change_state_to', self, 'kick')

	# # ground_pound?



	pass
