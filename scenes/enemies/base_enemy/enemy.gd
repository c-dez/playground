extends CharacterBody3D
class_name Enemy

@export var stats: CharacterStats
@export var attack_machine: StateMachine
@onready var navigation: NavigationAgent3D = get_node('NavigationAgent3D')


func _physics_process(_delta: float) -> void:
    if not is_on_floor():
        velocity = get_gravity()
    move_and_slide()