extends Area3D
class_name Hurtbox


func _ready() -> void:
    connect('area_entered', _on_area_entered)


func _on_area_entered(_hitbox: Hitbox) -> void:
    if _hitbox.owner is KatanaPlayer:
        if owner.has_method('take_damage'):
            var damage = _hitbox.owner.stats.damage
            owner.take_damage(damage)
    pass

