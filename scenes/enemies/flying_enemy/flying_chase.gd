extends Chase
# class_name FlyingChase

func physics_process(_delta: float) -> void:
	navigation_check_time -= _delta
	if navigation_check_time < 0:
		var height_offset := randi() % 5 + 1
		var target_position := Vector3(player.global_position.x, player.global_position.y + height_offset, player.global_position.z)
		var current_position := parent.global_position

		var direction := (target_position - current_position).normalized()

		parent.velocity = direction * parent.stats.move_speed
		parent.get_node('MeshInstance3D').look_at(target_position)

		navigation_check_time = _navigation_check_time
	parent.get_node('Muzzle').look_at(player.global_position)

	pass
