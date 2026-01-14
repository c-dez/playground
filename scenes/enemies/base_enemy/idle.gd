extends State
class_name Idle


var parent
@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')
var check_state_time:float = 3.0

func enter() -> void:
	print('idle enter')
	parent = get_parent().parent
	check_state_time = 3.0

	pass
func process(_delta: float) -> void:
	check_state_time -= _delta
	if check_state_time < 0:
		_change_state_to_chase()
		print(check_state_time)


func physics_process(_delta: float) -> void:
	parent.velocity = Vector3.ZERO

func exit() -> void:
	check_state_time = 3.0


func _change_state_to_chase() -> void:
	if parent.global_position.distance_to(player.global_position) < parent.stats.chase_range:
		emit_signal('change_state_to', self,'chase')
