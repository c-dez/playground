extends CharacterBody3D
class_name KatanaPlayer

## Third person player camera


@export var stats: CharacterStats
@onready var sm: StateMachine = get_node('StateMachine')

# jump gravity
@export var jump_height: float = 5.0
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descend: float = 0.6
var _jump_velocity: float
var _jump_gravity: float
var _jump_fall_gravity: float
####

@onready var mesh: MeshInstance3D = get_node('MeshInstance3D')

#Hitboxes
@onready var hitbox: Hitbox = get_node('AttackHitbox')
@onready var ground_pound_hitbox: Hitbox = get_node('GroundPoundHitbox')


var last_velocity

var wall_normal = null

# wallKickRays
## nodo que contiene los rays para kick/wall_kick states
@onready var wall_kick_rays: Node3D = get_node('WallKickRays')
@onready var wall_ray: RayCast3D = wall_kick_rays.get_node('WallRay')
@onready var wall_ray2: RayCast3D = wall_kick_rays.get_node('WallRay2')
## detecta suelo para evitar kick cuando cerca de suelo
@onready var ground_ray: RayCast3D = wall_kick_rays.get_node('GroundRay')

# jump signal
signal jump_signal()


func _ready() -> void:
    _calculate_jump_gravity()
    mesh.top_level = true
    hitbox.top_level = true
    connect('jump_signal', on_jump)


func _process(_delta: float) -> void:
    mesh.global_position = global_position
    hitbox.rotation = mesh.rotation
    hitbox.global_position = global_position

    wall_kick_rays.rotation = mesh.rotation
    wall_kick_rays.global_position = mesh.global_position

    
func _physics_process(_delta: float) -> void:
    jump()
    coyote_time(_delta)
   
    detect_wall_normall()
    move_and_slide()


func detect_wall_normall() -> void:
    if wall_ray.is_colliding():
        wall_normal = wall_ray.get_collision_normal()
    elif wall_ray2.is_colliding():
        wall_normal = wall_ray2.get_collision_normal()
    else:
        wall_normal = null


func move(delta: float, speed_multiplier: int) -> void:
    var input_dir := PlayerInput.get_direction()
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

    if direction:
        velocity.x = direction.x * stats.move_speed * speed_multiplier
        velocity.z = direction.z * stats.move_speed * speed_multiplier

        rotate_mesh(direction, delta)
    else:
        velocity.x = move_toward(velocity.x, 0, stats.move_speed)
        velocity.z = move_toward(velocity.z, 0, stats.move_speed)


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
    if sm.current_state == sm.states['groundpoundonfloor']:
        # salto desde state ground pound floor
        pass
    elif sm.current_state == sm.states['slidejump']:
        pass
    else:
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


func take_damage(_damage):
    # print(damage)
    pass


func take_health(damage):
    print(damage)


func attack_jump() -> void:
    if not is_on_floor():
        velocity.y = 20
