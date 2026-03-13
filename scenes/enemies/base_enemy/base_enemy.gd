extends CharacterBody3D
class_name BaseEnemy


@export var max_health : int = 100
var current_health: int:
    set(value):
        current_health = clamp(value, 0, max_health)

@onready var sm:StateMachine = get_node('StateMachine')

func _init() -> void:
    current_health = max_health

func _physics_process(_delta: float) -> void:
    move_and_slide()


func move() -> void:
    pass


func gravity(gravity_value:int) -> void:
    if not is_on_floor():
        velocity.y = gravity_value


func take_damage(damage:int) -> void:
    current_health -= damage
    if current_health == 0:
        die()
    pass


func die()-> void:
    print('die')

func launch_to_air() -> void:
    sm.on_state_change(sm.current_state, 'launchtoair')