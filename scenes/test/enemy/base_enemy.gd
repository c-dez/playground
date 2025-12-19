extends CharacterBody3D
class_name BaseEnemy


@export var stats: CharacterStats

# @export var test = res.health

func _ready() -> void:
	# res.health = 69
	# print(res.health)
	pass

func _process(_delta: float) -> void:
	dies()
	
	
	
func dies()->void:
	if stats.health <= 0:
		call_deferred('queue_free')
		print(name,' dies')

