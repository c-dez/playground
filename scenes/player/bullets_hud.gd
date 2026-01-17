extends TextureProgressBar


# BulletsHUD

@onready var proyectile_component: ProyectileComponent = get_parent().get_parent().get_node('ProyectileComponent')

var max_bullets: float = 6
var current_bullets: float

func _ready():
	value = 100
	proyectile_component.connect('player_shoot', on_player_shoot)

	
func on_player_shoot(_current_bullets: int) -> void:
	current_bullets = _current_bullets
	var percent = (current_bullets / max_bullets) * 100
	value = percent

	pass
