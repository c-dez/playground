extends CharacterBody3D
class_name Enemy

@export var max_health: int = 100

@export var move_speed: float = 5

@export var chase_speed: float = 5
@export var chase_range: float = 30

@export var attack_range: float = 15
@export var attack_cooldown: float = 0.3
@export var attack_damage: int = 10
@export var bullet_speed: float = 20

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group('player')
@onready var navigation: NavigationAgent3D = get_node('NavigationAgent3D')

var health: int:
    set(value):
        health = clamp(value, 0, max_health)

func _init() -> void:
    health = max_health


func _physics_process(_delta: float) -> void:
    gravity()
    move_and_slide()


func take_damage(_damage: int) -> void:
    health -= _damage
    if health == 0:
        die()
    pass


func gravity() -> void:
    if not is_on_floor():
        velocity.y = -10


func move(direction: Vector3, speed: float) -> void:
    velocity = direction * speed

func die() -> void:
    queue_free()
    pass