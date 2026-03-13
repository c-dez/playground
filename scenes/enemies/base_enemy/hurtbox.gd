extends Hurtbox

# Base_enemy hurtbox

func _on_area_entered(hitbox: Hitbox) -> void:
    if hitbox == null:
        return
    if hitbox.name == "GroundPoundHitbox":
        if owner.has_method('launch_to_air'):
            owner.launch_to_air()