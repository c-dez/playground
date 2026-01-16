extends Node3D
class_name WallRunComponent

# @onready var wall_timer: Timer = get_node('WallTimer')
@onready var ray_right: RayCast3D = get_node('RayCast3DRight')
@onready var ray_left: RayCast3D = get_node('RayCast3DLeft')

var can_wall_run: bool = false
var wall_normal: Vector3
var wall_jump_tween_time:float = 0.1

func _physics_process(_delta: float) -> void:
	_is_touching_wall()
	get_wall_normal()
	pass

func _is_touching_wall() -> void:
	if ray_left.is_colliding() or ray_right.is_colliding():
		can_wall_run = true

	else:
		can_wall_run = false

		
func get_wall_normal() -> Vector3:
	if ray_left.is_colliding():
		wall_normal = ray_left.get_collision_normal()
	elif ray_right.is_colliding():
		wall_normal = ray_right.get_collision_normal()
	return wall_normal