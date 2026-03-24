extends Area3D

# KillZone

func _ready() -> void:
	connect('body_entered', on_player_entered)


func on_player_entered(body: Node3D) -> void:
	if body is KatanaPlayer:
		# TODO:
		# black screen
		# bloquear player control
		# time
		GameSettings.load_game()

		var pos: String = GameSettings.data['check_point_position']
		pos = pos.replace("(", "").replace(")", "")
		var parts := pos.split(",")
		## Vector4(x,y,z,w)
		var parse_pos := Vector4(
			parts[0].to_float(),
			parts[1].to_float(),
			parts[2].to_float(),
			parts[3].to_float() # rotation
		)

		body.global_position = Vector3(parse_pos.x, parse_pos.y, parse_pos.z)
		body.rotation.y = parse_pos.w
