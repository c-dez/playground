extends CharacterBody3D
class_name Enemy

@export var stats: CharacterStats
@export var attack_machine: StateMachine
@onready var navigation: NavigationAgent3D = get_node('NavigationAgent3D')
@onready var muzzle: Node3D = get_node('Muzzle')

var health:int

func _ready() -> void:
    stats.duplicate(true)
    health = stats.health


func _physics_process(_delta: float) -> void:
    # falta poder especificar si vuela o es grounded su movimiento
    if not is_on_floor():
        velocity = get_gravity()
    move_and_slide()



func take_damage(damage:int)->void:
    health -= damage
    print(health)
    if health <= 0:
        queue_free()
