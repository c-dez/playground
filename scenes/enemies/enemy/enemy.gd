extends CharacterBody3D
class_name Enemy

@export var max_health: int

@export var move_speed: float

@export var chase_speed: float
@export var chase_range: float

@export var attack_range: float
@export var attack_cooldown: float

var health: int:
    set(value):
        health = clamp(value, 0, max_health)

@onready var navigation: NavigationAgent3D = get_node('NavigationAgent3D')


func _physics_process(delta: float) -> void:
    gravity()
    move_and_slide()


func take_damage(damage: int) -> void:
    print(damage)


func gravity() -> void:
    if not is_on_floor():
        velocity.y = -10