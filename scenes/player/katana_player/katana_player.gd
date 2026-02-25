extends CharacterBody3D
class_name KatanaPlayer

## Third person player camera


@export var stats: CharacterStats

# jump gravity
@export var jump_height: float = 5.0
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descend: float = 0.6
var _jump_velocity: float
var _jump_gravity: float
var _jump_fall_gravity: float
####

## top_level = true, su posicion  y rotacion se maneja independiente
@onready var mesh: MeshInstance3D = get_node('MeshInstance3D')


# wall_kick
@onready var kick_area: Area3D = mesh.get_node('KickArea')

# jump signal
signal jump_signal()

func _ready() -> void:
	_calculate_jump_gravity()
	mesh.top_level = true

	kick_area.monitoring = true
	# kick_area.connect('body_entered', on_kick_area_entered)

	connect('jump_signal', on_jump)


func _process(_delta: float) -> void:
	mesh.global_position = global_position
	# print(kick_area.monitoring)


func _physics_process(_delta: float) -> void:
	# wall_kick(_delta)
	coyote_time(_delta)
	jump()
	gravity(_delta)
	move_and_slide()


func gravity(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0.0:
			velocity.y -= _jump_fall_gravity * delta
		else:
			velocity.y -= _jump_gravity * delta


func jump() -> void:
	if PlayerInput.jump_input_buffered() and (can_jump):
		if is_on_floor():
			emit_signal('jump_signal')
		elif can_jump:
			emit_signal('jump_signal')


func on_jump() -> void:
		velocity.y = _jump_velocity
		_coyote = 0


const coyote: float = 0.3
var _coyote: float = 0.0
var can_jump: bool = false
func coyote_time(delta) -> void:
	if is_on_floor():
		_coyote = coyote
	elif not is_on_floor():
		_coyote -= delta
	
	can_jump = _coyote > 0 as bool


func rotate_mesh(direction: Vector3, delta: float, speed: float = 12.0) -> void:
	var target_angle := Vector3.BACK.signed_angle_to(direction, Vector3.UP)
	mesh.global_rotation.y = lerp_angle(mesh.global_rotation.y, target_angle, speed * delta)


func _calculate_jump_gravity() -> void:
	_jump_velocity = 2.0 * jump_height / jump_time_to_peak
	_jump_gravity = 2.0 * jump_height / (jump_time_to_peak * jump_time_to_peak)
	_jump_fall_gravity = 2.0 * jump_height / (jump_time_to_descend * jump_time_to_descend)


func take_damage(damage):
	print(damage)

func take_health(damage):
	print(damage)

# func wall_kick(delta) -> void:

# 	if PlayerInput.can_move == false:
# 		var input_dir = capture
# 		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
# 		velocity.x = direction.x * stats.move_speed*2
# 		velocity.z = direction.z * stats.move_speed*2
# 		velocity.y = 2
# 		rotate_mesh(direction,delta)
# 	if Input.is_action_just_pressed('space') and !is_on_floor():
# 		capture = PlayerInput.get_direction()

# 		kick_area.monitoring = true
# 		PlayerInput.can_move = false
# 		await get_tree().create_timer(0.3).timeout
# 		kick_area.monitoring = false
# 		PlayerInput.can_move = true


	pass

func on_kick_area_entered(area) -> void:
	print(area)
	pass
