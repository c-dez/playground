extends State


@onready var sm: StateMachine = get_parent()
@onready var timer:Timer = Timer.new()

var enter_velocity

func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false

func enter() -> void:
	print(name)
	timer.start(0.2)
	enter_velocity = sm.parent.velocity
	pass

func physics_process(_delta: float) -> void:
	_change_state_to()
	var input_dir := PlayerInput.get_direction()
	var direction := (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# timer de duracion de kick
		# impulsar en y
	if timer.time_left as bool:
		sm.parent.velocity.y = 2
		sm.parent.velocity.x = enter_velocity.x * 1.5
		sm.parent.velocity.z = enter_velocity.z * 1.5
		# sm.parent.rotate_mesh(direction,_delta, 12)





func _change_state_to() -> void:
	if sm.parent.is_on_floor():
		emit_signal('change_state_to', self, 'move')
