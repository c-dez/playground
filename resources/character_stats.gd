extends Resource
class_name CharacterStats

@export var health: int = 1
@export var damage: int = 1

@export var move_speed: float = 1
@export var jump_force: float = 1

@export var type: Type = 0 as Type

enum Type {
    ENEMY, 
    PLAYER
}
