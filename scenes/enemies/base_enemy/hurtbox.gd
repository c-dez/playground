extends Hurtbox

# Base_enemy hurtbox
var attack_damage: int = 20
var ground_pound_damage: int = 10


func _on_area_entered(hitbox: Hitbox) -> void:
    if hitbox == null:
        return
    if hitbox.name == "GroundPoundHitbox":
        if owner.has_method('launch_to_air'):
            owner.launch_to_air()

    if hitbox.name == 'AttackHitbox':
        owner.juggle()
