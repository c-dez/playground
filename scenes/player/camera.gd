extends Camera3D
## Controla la camara de el jugador
class_name PlayerCamera

@export var mouse_sens_horizontal: float = 0.1
@export var mouse_sens_vertical: float = 0.07

var look_up_deg: int = 50
var look_down_deg: int = -70


@onready var player: PlayerBody = get_parent()

func mouse_mode() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.relative:
			player.rotate_y(deg_to_rad(-event.relative.x * mouse_sens_horizontal))

			var max_rad: float = deg_to_rad(look_up_deg)
			var min_rad: float = deg_to_rad(look_down_deg)
			rotate_x(deg_to_rad(-event.relative.y * mouse_sens_vertical))
			rotation.x = clamp(rotation.x, min_rad, max_rad)
			rotation.z = clamp(rotation.z, 0, 0)
