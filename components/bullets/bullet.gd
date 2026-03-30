extends RigidBody3D
class_name Bullet

@onready var hitbox: Hitbox = get_node('Hitbox')
var damage: int = 0
var is_active:bool = false
    
        


func _ready() -> void:
    top_level = true
    hitbox.connect('area_entered', on_area_entered)
    set_active(false)


func on_area_entered(area: Hurtbox) -> void:
    if area.owner.has_method('take_damage'):
        area.owner.take_damage(damage)


func set_active(value: bool = false) -> void:
    visible = value
    hitbox.set_monitoring(value)
    hitbox.set_monitorable(value)
    is_active = value
    print(is_active)

