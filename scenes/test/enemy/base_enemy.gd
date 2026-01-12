extends CharacterBody3D
class_name BaseEnemyOld

## Clase base para enemigos
# old

@onready var nav: NavigationAgent3D = get_node("NavigationAgent3D")

@export var stats: CharacterStats

@export var detection_range:int = 10

func _ready() -> void:
	
	pass

func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity()

	move_and_slide()
	dies()
	
	

func dies()->void:
	if stats.health <= 0:
		call_deferred('queue_free')
		print(name,' dies')

