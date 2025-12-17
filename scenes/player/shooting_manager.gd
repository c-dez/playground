extends Node3D
class_name ShootingManager

var target_enemy: CharacterBody3D
var target_collision_point: Vector3

@export var camera: Camera3D
@onready var ray_cast: RayCast3D = get_node("ShootingRayCast")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	_set_tranform()
	shoot()


func shoot() -> void:
	if PlayerInput.left_mb():
		if ray_cast.is_colliding():
			target_collision_point = ray_cast.get_collision_point()
		else:
			target_collision_point = Vector3.ZERO

		if ray_cast.get_collider() is CharacterBody3D:
		# if ray_cast.get_collider().get_property_list()
			target_enemy = ray_cast.get_collider()
	
		# danar target si esta en grupo 'enemy'
		if target_enemy.is_in_group('enemy'):
			print(target_enemy.stats.health)


## usa el tranforn de camera  como el propio
func _set_tranform() -> void:
	position = camera.position
	rotation = camera.rotation
