extends Area3D

# KillZone

func _ready() -> void:
	connect('body_entered', on_player_entered)


func on_player_entered(body: Node3D) -> void:
	if body is KatanaPlayer:
		# black screen
		# bloquear player control
		# time
		GameSettings.load_game()

		var pos: String = GameSettings.data['check_point_position']
		pos = pos.replace("(", "").replace(")", "")
		var parts := pos.split(",")

		var parse_pos := Vector3(
			parts[0].to_float(),
			parts[1].to_float(),
			parts[2].to_float()
		)

		body.global_position = parse_pos
