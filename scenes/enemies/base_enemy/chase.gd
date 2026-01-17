extends State
class_name Chase


var check_state_time: float
var _check_state_time: float = 1.0
@onready var parent: Enemy = get_parent().get_parent()
@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')

func enter() -> void:
	check_state_time = _check_state_time


func process(_delta: float) -> void:
	check_state_time -= _delta
	if check_state_time < 0:
		_change_state_to()
		check_state_time = _check_state_time


func physics_process(_delta: float) -> void:
	parent.navigation.target_position = Vector3(player.global_position.x, parent.global_position.y, player.global_position.z)

	var current_pos := parent.global_position
	var next_pos := parent.navigation.get_next_path_position()
	var direction = (next_pos - current_pos).normalized()

	parent.velocity = direction * parent.stats.move_speed

	parent.get_node('MeshInstance3D').look_at(parent.navigation.target_position)


func exit() -> void:
	check_state_time = _check_state_time


func _change_state_to() -> void:
	# idle
	if parent.global_position.distance_to(player.global_position) > parent.stats.chase_range:
		emit_signal('change_state_to', self, 'idle')
	# attack
	elif parent.global_position.distance_to(player.global_position) < parent.stats.attack_range:
		if parent.muzzle.ray.is_colliding():
			var target = parent.muzzle.ray.get_collider()
			if target is PlayerBody:
				emit_signal('change_state_to', self, 'attack')
