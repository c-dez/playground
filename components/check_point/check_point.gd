extends Area3D

# Check_point -> al Player entrar a area, guarda su global_position(in_floor)
var check_point_position := Vector4.ZERO

func _ready() -> void:
    connect('body_entered', on_player_entered)


func on_player_entered(body: Node3D) -> void:
    if body is KatanaPlayer:
        var player_pos: Vector3 = body.global_position

        # se tiene que sumar 0.5 en y para que coincida con Player y que 'y' axis sea en el suelo
        check_point_position = Vector4(player_pos.x, global_position.y + 0.5, player_pos.z,body.rotation.y)
        GameSettings.data['check_point_position'] = check_point_position
        GameSettings.save_game()
        print('check_point')
    pass
