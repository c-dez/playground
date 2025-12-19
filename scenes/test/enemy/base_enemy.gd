extends CharacterBody3D
class_name BaseEnemy

## Clase base para enemigos


@export var stats: CharacterStats

@export var detection_range:int = 10

func _ready() -> void:
	
	pass

func _process(_delta: float) -> void:
	dies()
	
	
	
func dies()->void:
	if stats.health <= 0:
		call_deferred('queue_free')
		print(name,' dies')

