extends CharacterBody3D
class_name PlayerBody


## Controla el movimiento de Player   


@export var stats: CharacterStats
## uso un Vector2 para representar rango entre dos valores usado para active_reload system
@export var active_reload_range := Vector2(40, 60)

var dash_time: float = 0.5
var dash_mult = 1.0
const DASH_MULT_DEFAULT: float = 1.0
var current_move_state: move_states = 1 as move_states
enum move_states {
	walk,
	run,
	dash
}
# wall run

@onready var wall_run_component: WallRunComponent = get_node('WallRunComponent')

# jump gravity
@export var jump_height: float = 1.0
@export var jump_time_to_peak: float = 0.4
@export var jump_time_to_descend: float = 0.3

var _jump_velocity: float
var _jump_gravity: float
var _jump_fall_gravity: float

# HUD
@onready var health_bar: ProgressBar = get_node('HUD/HealthBar')

# test damage_area
var damage_area: PackedScene = preload('res://assets/damage_area/damage_area.tscn')

func _ready() -> void:
	_calculate_jump_gravity()
	# debug
	# uso un mesh para el jugador para poder visualizarlo en godot, en juego no se debe  de mostrar este mesh
	# get_node("MeshInstance3D").visible = false
	_set_healthbar_value()

	pass
	
var test_time = 5
func _physics_process(delta: float) -> void:
	gravity(delta)
	# apply_gravity(delta)
	# wall_run()
	dash(delta)
	move()
	jump()
	wall_jump()
	coyote_time(delta)
	move_and_slide()
	# print(can_wall_run)

	# test damage_area
	# if Input.is_action_just_pressed('e_key'):
	if is_on_floor():
		test_time-= delta
	if test_time < 0:
		var d = damage_area.instantiate()
		# d.damage = randi() %20
		add_child(d)
		test_time = 5
	

func jump() -> void:
	if PlayerInput.jump_input_buffered() and (is_on_floor() or can_jump):
		# velocity.y = stats.jump_force
		velocity.y = _jump_velocity


func move() -> void:
	var input_dir := PlayerInput.get_direction()
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * stats.move_speed * dash_mult
		velocity.z = direction.z * stats.move_speed * dash_mult
	else:
		velocity.x = move_toward(velocity.x, 0, stats.move_speed)
		velocity.z = move_toward(velocity.z, 0, stats.move_speed)
		

func dash(delta: float) -> void:
	# no me gusta esta implementacion pero por ahora funciona correctamente
	if current_move_state == move_states.run:
		if PlayerInput.right_mb():
			current_move_state = move_states.dash

	if current_move_state == move_states.dash:
		dash_time -= delta
	
		if dash_time >= 0.0:
			dash_mult = 2
		else:
			current_move_state = move_states.run
			dash_time = 0.5
			dash_mult = DASH_MULT_DEFAULT


func gravity(delta: float):
	if not is_on_floor():
		if velocity.y < 0.0:
			velocity.y -= _jump_fall_gravity * delta
		else:
			velocity.y -= _jump_gravity * delta

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		if wall_run_component.can_wall_run == false:
			velocity += get_gravity() * delta


# wall run DESACTIVADO
func wall_run() -> void:
	if wall_run_component.can_wall_run:
		if not is_on_floor():
			velocity.y = -2


func wall_jump() -> void:
	if wall_run_component.can_wall_run == true:
		if PlayerInput.jump_input_buffered():
			var tween = get_tree().create_tween()
			# no funciona como esperaba, solo aplica valor en Y, en el futuro revisar esto o simplificar logica
			var final_value := Vector3(
				wall_run_component.wall_normal.x * 5,
				_jump_velocity * 0.9,
				wall_run_component.wall_normal.z * 5
				)
			tween.tween_property(self, "velocity", final_value, wall_run_component.wall_jump_tween_time)


# coyote time
const coyote: float = 0.2
var _coyote: float = 0.0
var can_jump: bool = false
func coyote_time(delta) -> void:
	if is_on_floor():
		_coyote = coyote
	elif not is_on_floor():
		_coyote -= delta
	
	can_jump = _coyote > 0 as bool


func _calculate_jump_gravity() -> void:
	_jump_velocity = 2.0 * jump_height / jump_time_to_peak
	_jump_gravity = 2.0 * jump_height / (jump_time_to_peak * jump_time_to_peak)
	_jump_fall_gravity = 2.0 * jump_height / (jump_time_to_descend * jump_time_to_descend)


func take_damage(damage: int) -> void:
	stats.health -= damage
	_set_healthbar_value()
	# print(stats.health)
	if stats.health <= 0:
		print('player dies!')


func _set_healthbar_value() -> void:
	var current_health: float = stats.health
	var percent := (current_health / stats.max_health) * 100
	health_bar.value = percent
