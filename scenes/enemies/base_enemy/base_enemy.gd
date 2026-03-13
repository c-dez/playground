extends CharacterBody3D
class_name BaseEnemy


@export var max_health : int = 100
var current_health: int:
    set(value):
        current_health = clamp(value, 0, max_health)

@onready var sm:StateMachine = get_node('StateMachine')

func _init() -> void:
    current_health = max_health



func gravity() -> void:
    if not is_on_floor():
        velocity.y = -10


func take_damage(damage:int) -> void:
    current_health -= damage
    if current_health == 0:
        die()
    pass


func die()-> void:
    print('die')