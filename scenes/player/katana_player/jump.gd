extends State


@onready var sm: StateMachine = get_parent()

var speed = 10

# var jump_multiplier := 1.2
var initial_height: float
var rotate_speed: float = 4

func enter() -> void:
	# jump()

	sm.parent.mesh.do_squash_and_stretch(1.2, 0.20)
	initial_height = sm.parent.global_position.y
	# print('jump')
	pass


func physics_process(_delta: float) -> void:
	_change_state_to()
	move(_delta)


# func jump() -> void:
# 	speed = sm.parent.stats.move_speed * jump_multiplier
# 	sm.parent.velocity.y = sm.parent._jump_velocity


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
	# 	pass
	# # wall_kick
	# 	# capturar altura inicial
	# 	# si es mayor a x altura
	# 		# cambia a wall_kick
	elif sm.parent.global_position.y - initial_height > 2:
		if Input.is_action_just_pressed('space'):
			emit_signal('change_state_to', self, 'kick')
	# # ground_pound?


	# elif sm.parent.global_position.y - initial_height < 0.5:
	# 	emit_signal('change_state_to', self, 'move')
	pass
