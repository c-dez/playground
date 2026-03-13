extends Hurtbox

# Base_enemy hurtbox
var attack_damage: int = 20
var ground_pound_damage: int = 10


func _on_area_entered(hitbox: Hitbox) -> void:
    if hitbox == null:
        return
    if hitbox.name == "GroundPoundHitbox":
        if owner.has_method('launch_to_air'):
            if owner.is_on_floor():
                owner.launch_to_air()
                owner.take_damage(ground_pound_damage)

    if hitbox.name == 'AttackHitbox':
        if owner.is_on_floor():
            owner.take_damage(attack_damage)
        else:
            owner.juggle()
