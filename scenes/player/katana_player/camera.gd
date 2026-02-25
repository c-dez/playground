extends SpringArm3D
# controla rotacion de la camara y la rotacion de player(excepto mesh)
@onready var camera: Camera3D = get_node('Camera3D')
@onready var player: KatanaPlayer = get_parent()


# var mouse_sens: float = 0.1 / 3
var mouse_sens: float = GameSettings.data['mouse_sens']
var gamepad_sens_h: float = 3.0
var gamepad_sens_v: float = 2.0


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(_delta: float) -> void:
	#gamepad camera
	#horizontal
	var axis := Input.get_vector('camera_left','camera_right','camera_up','camera_down')


	if axis.length() >0.2:
		#vertical
		rotate_x(deg_to_rad(- axis.y * gamepad_sens_v))
		# horizontal
		player.rotate_y(deg_to_rad(-axis.x * gamepad_sens_h))

		#clamp
		var max_rad := deg_to_rad(50)
		var min_rad := deg_to_rad(-70)
		rotation.x = clamp(rotation.x, min_rad, max_rad)
		rotation.z = clamp(rotation.z, 0, 0)



	pass
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.relative:
			player.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))

			var max_rad := deg_to_rad(50)
			var min_rad := deg_to_rad(-70)

			rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
			rotation.x = clamp(rotation.x, min_rad, max_rad)
			rotation.z = clamp(rotation.z, 0, 0)
