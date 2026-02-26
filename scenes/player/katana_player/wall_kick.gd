extends State

@onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
var wall_normal
var input_dir
var direction


func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false


func enter() -> void:
	# print(name)
	timer.start(0.3)
	# var forward = -sm.parent.transform.basis.z.normalized()
	wall_normal = sm.parent.wall_normal
	input_dir = PlayerInput.get_direction()
	direction = (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


func physics_process(_delta: float) -> void:
	_change_state_to()
	if not sm.parent.wall_normal == null:
		# var forward = -sm.parent.transform.basis.z.normalized()
		# # print(forward)
		# if sm.parent.last_velocity.length() > 0.2:
		# 	sm.parent.velocity = sm.parent.last_velocity.bounce(sm.parent.wall_normal) * 1.2
		# 	sm.parent.velocity.y = 12
		# else:
		# 	# print('sadasd')
		# 	# sm.parent.velocity = forward.bounce(sm.parent.wall_normal)* 12
		# 	pass
		if direction:
			sm.parent.velocity = direction.bounce(sm.parent.wall_normal) * 10
			sm.parent.velocity.y = 10
		else:
			var forward = sm.parent.mesh.transform.basis.z.normalized()

			sm.parent.velocity = forward.bounce(sm.parent.wall_normal) * 12
			sm.parent.velocity.y = 10


	#   if sm.parent.in_wall:
	# 	var forward = - sm.parent.transform.basis.z.normalized()
	# 	sm.parent.velocity = forward.bounce(sm.parent.wall_normal) * 12
	# 	sm.parent.velocity.y = 12
	# 	print(sm.parent.velocity)


func exit() -> void:
	sm.last_state = sm.states['wallkick']


func _change_state_to() -> void:
	if not timer.time_left as bool:
		emit_signal('change_state_to', self, 'air')
	pass
