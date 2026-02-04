extends Resource
class_name KatanaStats


## Stats para enemigos y player como health, damage, move_speed 
##  y metodos para modificarlos como take_damage()
@export var max_health: int = 500
@export var health: int = 500

@export var ligth_damage: int = 10
@export var heavy_damage: int = 20
@export var combo_damage: int = 15
@export var special_damage: int = 25

@export var attack_range: int = 20
@export var light_range: int = 3
@export var heavy_range: int = 8
@export var combo_range: int = 10
@export var special_range: int = 15

@export var chase_range: int = 100
@export var attack_cooldown: float = 1

@export var move_speed: float = 10
@export var walk_speed: float = 5
@export var dash_speed: float = 15

@export var type: Type = Type.ENEMY
enum Type {
    ENEMY,
    PLAYER
}


