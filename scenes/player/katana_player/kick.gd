extends State


@onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
# @onready var kick_area:Area3D = sm.parent.kick_area

var last_velocity


# wall_kick
const kick_count: int = 3
var _kick_count: int = kick_count
var duration_time: float = 0.3

func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false

	# wall_kick
	# await get_tree().create_timer(0.2).timeout
	# sm.parent.kick_area.connect('area_entered', on_kick_area_entered)

func enter() -> void:
	# print(name)
	timer.start(duration_time)
	last_velocity = sm.parent.velocity
	sm.parent.last_velocity = last_velocity
	_kick_count = kick_count
	# sm.parent.kick_area.monitoring = true
	# print('last_velocity ', last_velocity)

	pass

func physics_process(_delta: float) -> void:
	_change_state_to()
	# var input_dir := PlayerInput.get_direction()
	# var direction := (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# timer de duracion de kick
		# impulsar en y
	if timer.time_left as bool and _kick_count > 0:
		# _kick_count -= 1
		# if last_velocity.x == 0:
		# 	sm.parent.velocity.y = 2
		# 	var forward = - sm.parent.transform.basis.z.normalized()

		# 	sm.parent.velocity = forward *8
		# 	# print(forward)

		# 	sm.parent.rotate_mesh(-sm.parent.transform.basis.z.normalized(), _delta, 20)
		# 	pass
		# else:
		# 	sm.parent.velocity.y = 4
		# 	sm.parent.velocity.x = last_velocity.x * 1.5
		# 	sm.parent.velocity.z = last_velocity.z * 1.5
		# 	sm.parent.rotate_mesh(last_velocity, _delta, 12)
		sm.parent.velocity.y = 0

func exit() -> void:
	# sm.parent.kick_area.monitoring = false
	sm.last_state = self


func _change_state_to() -> void:
	if sm.parent.is_on_floor():
		_kick_count = kick_count
		emit_signal('change_state_to', self, 'move')

	elif timer.time_left <= 0:
		if not sm.parent.is_on_floor():
			emit_signal('change_state_to', self, 'air')

	elif sm.parent.wall_normal != null:
		emit_signal('change_state_to', self, 'wallkick')
		# var list = sm.parent.kick_area.get_overlapping_bodies()
		# for item in list:
		# 	if item is not KatanaPlayer:
		# 		pass
		# 	else:
		# 		# print(list)
		
		pass


# func on_kick_area_entered(area) -> void:
# 	print(area)
# 	_kick_count -= 1
# 	sm.parent.velocity.y = 2
# 	sm.parent.velocity.x = last_velocity.x * -1.5
# 	sm.parent.velocity.z = last_velocity.z * -1.5

# 	pass