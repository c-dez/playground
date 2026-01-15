extends Resource
class_name CharacterStats

## Stats para enemigos y player como health, damage, move_speed 
##  y metodos para modificarlos como take_damage()

@export var health: int = 100
@export var damage: int = 10
@export var attack_range: int = 30
@export var chase_range: int = 20
@export var attack_cooldown:float = 1

@export var move_speed: float = 1
@export var walk_speed : float = 1
@export var dash_speed: float = 1
@export var jump_force: float = 1

@export var type: Type = 0 as Type
enum Type {
    ENEMY,
    PLAYER
}



func take_damage(_damage_ammount: int) -> void:
    health -= _damage_ammount
 

func take_heal(_heal_ammount: int) -> void:
    health += _heal_ammount