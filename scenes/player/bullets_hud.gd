extends TextureProgressBar


# HUD para indicar el numero de balas que se pueden disparar

@onready var proyectile_component: ProyectileComponent = get_parent().get_parent().get_node('ProyectileComponent')

var max_bullets: float
var current_bullets: float

func _ready():
	var max_percentage := 100
	value = max_percentage
	max_bullets = proyectile_component.max_bullets
	proyectile_component.connect('current_bullets_update', on_current_bullets_update)

	
func on_current_bullets_update(_current_bullets: int) -> void:
	current_bullets = _current_bullets
	var percent := (current_bullets / max_bullets) * 100
	value = percent

	pass
