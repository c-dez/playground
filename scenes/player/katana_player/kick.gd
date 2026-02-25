extends State


@onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
# @onready var kick_area:Area3D = sm.parent.kick_area

var enter_velocity


# wall_kick
const kick_count: int = 3
var _kick_count: int = kick_count

func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false

	# wall_kick
	# await get_tree().create_timer(0.2).timeout
	# sm.parent.kick_area.connect('area_entered', on_kick_area_entered)

func enter() -> void:
	print(name)
	timer.start(0.2)
	enter_velocity = sm.parent.velocity
	_kick_count = kick_count
	sm.parent.kick_area.monitoring = true

	pass

func physics_process(_delta: float) -> void:
	_change_state_to()
	# var input_dir := PlayerInput.get_direction()
	# var direction := (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# timer de duracion de kick
		# impulsar en y
	if timer.time_left as bool and _kick_count > 0:
		_kick_count -= 1
		sm.parent.velocity.y = 2
		sm.parent.velocity.x = enter_velocity.x * 1.5
		sm.parent.velocity.z = enter_velocity.z * 1.5
		# sm.parent.rotate_mesh(direction,_delta, 12)
		print()

func exit() -> void:
	sm.parent.kick_area.monitoring = false


func _change_state_to() -> void:
	if sm.parent.is_on_floor():
		_kick_count = kick_count
		emit_signal('change_state_to', self, 'move')
	elif timer.time_left <= 0:
		if not sm.parent.is_on_floor():
			emit_signal('change_state_to', self, 'air')
	elif sm.parent.kick_area.has_overlapping_bodies():
		emit_signal('change_state_to', self, 'wallkick')
		
		pass


# func on_kick_area_entered(area) -> void:
# 	print(area)
# 	_kick_count -= 1
# 	sm.parent.velocity.y = 2
# 	sm.parent.velocity.x = enter_velocity.x * -1.5
# 	sm.parent.velocity.z = enter_velocity.z * -1.5

# 	pass