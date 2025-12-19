extends CharacterBody3D
## Controla el movimiento de Player                                                                    
class_name PlayerBody


@export var stats: CharacterStats


func _ready() -> void:
	# debug
	# uso un mesh para el jugador para poder visualizarlo en godot, en juego no se debe  de mostrar este mesh
	get_node("MeshInstance3D").visible = false
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move()
	jump()
	move_and_slide()
	
	
func jump() -> void:
	if PlayerInput.jump_input_buffered() and is_on_floor():
		velocity.y = stats.jump_force


func move() -> void:
	var input_dir := PlayerInput.direction()
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * stats.move_speed
		velocity.z = direction.z * stats.move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, stats.move_speed)
		velocity.z = move_toward(velocity.z, 0, stats.move_speed)
