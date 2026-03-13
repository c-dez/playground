extends CharacterBody3D
class_name BaseEnemy

@onready var sm:StateMachine = get_node('StateMachine')


func take_damage(damage:int) -> void:
    print(damage)
    pass
