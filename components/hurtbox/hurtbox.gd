extends Area3D
class_name Hurtbox





func _ready() -> void:
    connect('area_entered', _on_area_entered)


func _on_area_entered(hitbox: Hitbox) -> void:
    if hitbox == null:
        return
    print(hitbox.owner.stats.damage)
    if owner.has_method('take_damage'):
        print(owner)
    pass