extends State
class_name Chase

var parent: Enemy
@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')

var check_state_time: float = 3.0

func enter() -> void:
	if parent == null:
		parent = get_parent().parent
	check_state_time = 3.0


func process(_delta: float) -> void:
	# check_state_time -= _delta
	# if check_state_time < 0:
	# 	_change_state_to_idle()
	_change_state_to_idle(_delta)
	pass
	

func physics_process(_delta: float) -> void:
	parent.navigation.target_position = Vector3(player.global_position.x, parent.global_position.y, player.global_position.z)
	# parent.navigation.target_position = player.global_position

	var current_pos := parent.global_position
	var next_pos := parent.navigation.get_next_path_position()
	var direction = (next_pos - current_pos).normalized()

	parent.velocity = direction * parent.stats.move_speed

	parent.look_at(parent.navigation.target_position)


func exit() -> void:
	check_state_time = 3.0


func _change_state_to_idle(_delta) -> void:
	if parent.global_position.distance_to(player.global_position) > parent.stats.attack_range:
		# check_state_time -= _delta
		# print(check_state_time)
		# if check_state_time < 0 :
		# 	emit_signal('change_state_to', self, 'idle')

		emit_signal('change_state_to', self, 'idle')
