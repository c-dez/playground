extends State
class_name EnemyWander

var wander_direction: Vector3 = Vector3.ZERO
var wander_time: float = 0.0
var look_at := Vector3.ZERO

func randomize_variables() -> void:
	wander_time = randf_range(1.5, 4)
	if randi_range(0, 3) != 3:
		wander_direction = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))
		
	else:
		wander_direction = Vector3.ZERO
		
		look_at = Vector3(randf_range(-1.0, 1.0), 0, randf_range(-1.0, 1.0))


func enter() -> void:
	randomize_variables()


func process(_delta: float) -> void:
	if wander_time < 0.0:
		randomize_variables()

	wander_time -= _delta

	if enemy.global_position.distance_to(player.global_position) < enemy.stats.attack_range:
			emit_signal('transitioned', self, 'EnemyChase')


func physics_process(_delta: float) -> void:
	enemy.velocity = wander_direction * enemy.stats.walk_speed

	look_at_direction()


func look_at_direction() -> void:
	var mesh = enemy.get_node('MeshInstance3D')
	if wander_direction == Vector3.ZERO:
		var angle = atan2(look_at.x, look_at.z)
		mesh.rotation.y = angle + PI
	else:
		var angle = atan2(wander_direction.x, wander_direction.z)
		mesh.rotation.y = angle + PI
	pass
