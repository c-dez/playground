extends State

@onready var sm: StateMachine = get_parent()

func enter() -> void:
	# print(name)
	pass
	

func process(_delta: float) -> void:
	_change_state_to()


func physics_process(_delta: float) -> void:
	move(_delta)


func move(delta) -> void:
	var input_dir := PlayerInput.get_direction()
	var direction := (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		sm.parent.velocity.x = direction.x * sm.parent.stats.move_speed
		sm.parent.velocity.z = direction.z * sm.parent.stats.move_speed

		sm.parent.rotate_mesh(direction, delta)
	else:
		sm.parent.velocity.x = move_toward(sm.parent.velocity.x, 0, sm.parent.stats.move_speed)
		sm.parent.velocity.z = move_toward(sm.parent.velocity.z, 0, sm.parent.stats.move_speed)


func _change_state_to() -> void:
	# if sm.parent.is_on_floor() and PlayerInput.jump_input_buffered(0.5):
	if !sm.parent.is_on_floor() :
		emit_signal('change_state_to', self, 'air')

		pass
