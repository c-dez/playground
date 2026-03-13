extends Area3D
class_name Hurtbox



func _ready() -> void:
	connect('area_entered', _on_area_entered)
	


func _on_area_entered(_hitbox: Hitbox) -> void:
	pass
