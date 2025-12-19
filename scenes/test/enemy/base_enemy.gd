extends CharacterBody3D
class_name BaseEnemy


@export var res: CharacterStats

# @export var test = res.health

func _ready() -> void:
	# res.health = 69
	print(res.health)
