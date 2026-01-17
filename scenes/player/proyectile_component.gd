extends Node3D
## usado para que player dispare
class_name ProyectileComponent

@onready var ray: RayCast3D = get_node('RayCast3D')
@onready var bullet: PackedScene = preload('res://components/bullet/bullet.tscn')
@onready var camera: Camera3D = get_parent().get_node('PlayerCamera')
@onready var muzzle: Marker3D = camera.get_node('Muzzle')
@onready var player: PlayerBody = get_parent()

var max_bullets: int = 6
var current_bullets:int
signal player_shoot(current_bullets)

func _ready() -> void:
	current_bullets = max_bullets
	pass


func _process(_delta: float) -> void:
	_set_position()


func _physics_process(_delta: float) -> void:
	shoot()


func shoot() -> void:
	if ray.is_colliding():
		if Input.is_action_just_pressed('left_mb') and current_bullets > 0:
			current_bullets -= 1
			emit_signal('player_shoot',current_bullets)
			var target = ray.get_collision_point()
			var b = bullet.instantiate()

			b.damage = player.stats.damage
			b.bullet_radius = 0.1
			b.type = b.PLAYER
			b.damage = player.stats.damage
			muzzle.add_child(b)
			b.look_at(target, Vector3.UP)


func _set_position() -> void:
	position = camera.position
	rotation = camera.rotation
