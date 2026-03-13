extends State


@onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()

var last_velocity


# wall_kick
const kick_count: int = 3
var _kick_count: int = kick_count
var duration_time: float = 0.5

func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false

	
func enter() -> void:
	# print(name)
	timer.start(duration_time)
	last_velocity = sm.parent.velocity
	sm.parent.last_velocity = last_velocity
	_kick_count = kick_count
	

	pass

func physics_process(_delta: float) -> void:
	_change_state_to()
	if timer.time_left as bool and _kick_count > 0:
		sm.parent.velocity.y = -1


func exit() -> void:
	# sm.last_state = self
	timer.stop()


func _change_state_to() -> void:
	if sm.parent.is_on_floor():
		_kick_count = kick_count
		emit_signal('change_state_to', self, 'move')

	elif timer.time_left <= 0:
		if not sm.parent.is_on_floor():
			emit_signal('change_state_to', self, 'air')

	elif sm.parent.wall_normal != null:
		emit_signal('change_state_to', self, 'wallkick')
# 