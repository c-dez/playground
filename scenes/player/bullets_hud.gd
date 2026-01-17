extends TextureProgressBar


# BulletsHUD

@onready var proyectile_component: ProyectileComponent = get_parent().get_parent().get_node('ProyectileComponent')

var max_bullets: float
var current_bullets: float

func _ready():
	var max_percentage := 100
	value = max_percentage
	max_bullets = proyectile_component.max_bullets
	proyectile_component.connect('player_shoot', on_player_shoot)

	
func on_player_shoot(_current_bullets: int) -> void:
	current_bullets = _current_bullets
	var percent := (current_bullets / max_bullets) * 100
	value = percent

	pass
