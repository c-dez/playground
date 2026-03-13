extends Area3D
class_name Hurtbox



func _ready() -> void:
	connect('area_entered', _on_area_entered)
	


func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null:
		return
	if owner.has_method('take_damage'):
		var damage:int= hitbox.owner.stats.damage
		owner.take_damage(damage)
		
	pass
