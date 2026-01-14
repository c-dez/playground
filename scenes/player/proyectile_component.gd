extends Node3D
class_name ProyectileComponent


@onready var ray: RayCast3D = get_node('RayCast3D')
@onready var bullet: PackedScene = preload('res://assets/bullet/bullet.tscn')
@onready var camera: Camera3D = get_parent().get_node('PlayerCamera')
@onready var muzzle: Marker3D = camera.get_node('Muzzle')
@onready var player: PlayerBody = get_parent()


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	_set_position()


func _physics_process(_delta: float) -> void:
	if ray.is_colliding():
		if Input.is_action_just_pressed('left_mb'):
			var target = ray.get_collision_point()
			var b = bullet.instantiate()
			b.type = b.PLAYER
			b.damage = player.stats.damage
			muzzle.add_child(b)
			b.look_at(target, Vector3.UP)

	
	pass


func _set_position() -> void:
	position = camera.position
	rotation = camera.rotation
