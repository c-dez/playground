extends TextureProgressBar


# BulletsHUD

@export var shooting_manager:ShootingManager

var max_bullets:float
var current_bullets:float


func _physics_process(_delta: float) -> void:
	max_bullets = shooting_manager.max_bullets
	current_bullets = shooting_manager.bullets

	var percent = (current_bullets/max_bullets) * 100
	value = percent
