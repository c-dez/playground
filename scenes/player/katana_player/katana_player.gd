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


func _ready() -> void:
	_calculate_jump_gravity()
	mesh.top_level = true


func _process(_delta: float) -> void:
	mesh.global_position = global_position


func _physics_process(_delta: float) -> void:
	move(_delta)
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
	if PlayerInput.jump_input_buffered() and is_on_floor():
		velocity.y = _jump_velocity


func move(delta) -> void:
	var input_dir := PlayerInput.get_direction()
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * stats.move_speed
		velocity.z = direction.z * stats.move_speed

		rotate_mesh(direction, delta)
	else:
		velocity.x = move_toward(velocity.x, 0, stats.move_speed)
		velocity.z = move_toward(velocity.z, 0, stats.move_speed)


func rotate_mesh(direction: Vector3, delta: float) -> void:
	var rotation_speed := 12
	var target_angle := Vector3.BACK.signed_angle_to(direction, Vector3.UP)
	mesh.global_rotation.y = lerp_angle(mesh.global_rotation.y, target_angle, rotation_speed * delta)


func _calculate_jump_gravity() -> void:
	_jump_velocity = 2.0 * jump_height / jump_time_to_peak
	_jump_gravity = 2.0 * jump_height / (jump_time_to_peak * jump_time_to_peak)
	_jump_fall_gravity = 2.0 * jump_height / (jump_time_to_descend * jump_time_to_descend)
