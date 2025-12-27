extends CharacterBody3D
class_name PlayerBody


## Controla el movimiento de Player   


@export var stats: CharacterStats
## uso un Vector2 para representar rango entre dos valores usado para active_reload system
@export var active_reload_range := Vector2(40, 60)

var dash_time: float = 0.5
var dash_mult = 2.0
const DASH_MULT_DEFAULT: float = 1.0
var current_move_state: move_states = 1 as move_states
enum move_states {
	walk,
	run,
	dash
}


func _ready() -> void:
	# debug
	# uso un mesh para el jugador para poder visualizarlo en godot, en juego no se debe  de mostrar este mesh
	get_node("MeshInstance3D").visible = false
	

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	dash(delta)
	move()
	jump()
	move_and_slide()
	
	
func jump() -> void:
	if PlayerInput.jump_input_buffered() and is_on_floor():
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
		velocity += get_gravity() * delta