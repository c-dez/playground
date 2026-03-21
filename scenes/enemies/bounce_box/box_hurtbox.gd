extends Hurtbox

func _on_area_entered(hitbox: Hitbox) -> void:
    if hitbox.name == 'GroundPoundHitbox':
        owner.launch_up()
    pass
