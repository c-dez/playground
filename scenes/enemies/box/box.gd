extends CharacterBody3D

# al ser golpeada por groundPound, box brinca
# nombre no me gusta lo ambiguo que es

# jump gravity
@export var jump_height: float = 7.0
@export var jump_time_to_peak: float = 0.3
@export var jump_time_to_descend: float = 1
var _jump_velocity: float
var _jump_gravity: float
var _jump_fall_gravity: float


func _ready() -> void:
	_calculate_jump_gravity()


func _physics_process(_delta: float) -> void:
	move_and_slide()
	gravity(_delta)
	pass


func _calculate_jump_gravity() -> void:
	_jump_velocity = 2.0 * jump_height / jump_time_to_peak
	_jump_gravity = 2.0 * jump_height / (jump_time_to_peak * jump_time_to_peak)
	_jump_fall_gravity = 2.0 * jump_height / (jump_time_to_descend * jump_time_to_descend)


func gravity(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0.0:
			velocity.y -= _jump_fall_gravity * delta
		else:
			velocity.y -= _jump_gravity * delta

func launch_up() -> void:
	velocity.y = _jump_velocity
