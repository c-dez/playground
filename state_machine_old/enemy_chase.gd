extends State
class_name EnemyChase


@onready var enemy: BaseEnemy = get_parent().get_parent()
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group('player')

func process(_delta: float) -> void:
	enemy.nav.set_target_position(player.global_position)

	if enemy.global_position.distance_to(player.global_position) > enemy.stats.attack_range:
		emit_signal('change_state_to', self, 'EnemyWander')

	# if enemy.global_position.distance_to(player.global_position) < enemy.stats.chase_range:
	# 	emit_signal('transitioned',self,'EnemyAttack')


func physics_process(_delta: float) -> void:
	if enemy.nav.is_navigation_finished():
		return

	var next_pos: Vector3 = enemy.nav.get_next_path_position()
	enemy.velocity = enemy.global_position.direction_to(next_pos) * enemy.stats.move_speed
	_look_at_player()

	
func _look_at_player() -> void:
	var mesh = enemy.get_node('MeshInstance3D')
	var target = player.global_position - mesh.global_position
	target.y = 0
	target = target.normalized()

	var angle = atan2(target.x, target.z)
	mesh.rotation.y = angle + PI
