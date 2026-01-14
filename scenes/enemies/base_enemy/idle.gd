extends State
class_name Idle


@onready var parent: Enemy = get_parent().get_parent()
@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')
var check_state_time: float
var _check_state_time: float = 1.0


func enter() -> void:
	check_state_time = _check_state_time


func process(_delta: float) -> void:
	check_state_time -= _delta
	if check_state_time < 0:
		_change_state_to()
		check_state_time = _check_state_time


func physics_process(_delta: float) -> void:
	parent.velocity = Vector3.ZERO

func exit() -> void:
	check_state_time = _check_state_time


func _change_state_to() -> void:
	# chase
	if parent.global_position.distance_to(player.global_position) < parent.stats.chase_range:
		emit_signal('change_state_to', self, 'chase')
