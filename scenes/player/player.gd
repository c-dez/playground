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
var can_wall_run: bool = false
var wall_normal: Vector3


func _ready() -> void:
	# debug
	# uso un mesh para el jugador para poder visualizarlo en godot, en juego no se debe  de mostrar este mesh
	get_node("MeshInstance3D").visible = false
	pass
	

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	wall_run()
	dash(delta)
	move()
	jump()
	coyote_time(delta)
	move_and_slide()
	

func jump() -> void:
	if PlayerInput.jump_input_buffered() and (is_on_floor() or can_jump):
		velocity.y = stats.jump_force


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


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		if can_wall_run == false:
			velocity += get_gravity() * delta


# wall run
func wall_run() -> void:
	if is_on_wall_only():
		await get_tree().create_timer(0.2).timeout
		can_wall_run = true
		wall_normal = get_wall_normal()

	else:
		can_wall_run = false
	if can_wall_run:
		print(can_wall_run)
		velocity = Vector3(-wall_normal.x, 0, -wall_normal.z) * stats.move_speed


	pass

	
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