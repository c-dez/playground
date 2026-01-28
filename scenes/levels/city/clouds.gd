extends Area3D

func _ready() -> void:
	connect('body_entered',on_player_entered)


func on_player_entered(body):
	if body is PlayerBody:
		body.position = body.last_position
