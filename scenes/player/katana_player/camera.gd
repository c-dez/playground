extends SpringArm3D

@onready var camera: Camera3D = get_node('Camera3D')
@onready var player: KatanaPlayer = get_parent()


# var mouse_sens: float = 0.1 / 3
var mouse_sens:float = GameSettings.data['mouse_sens']

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print(mouse_sens)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.relative:
			player.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))

			var max_rad:= deg_to_rad(50)
			var min_rad := deg_to_rad(-70)

			rotate_x(deg_to_rad(- event.relative.y * mouse_sens))
			rotation.x = clamp(rotation.x, min_rad, max_rad)
			rotation.z = clamp(rotation.z, 0, 0)
