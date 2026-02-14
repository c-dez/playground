extends RigidBody3D
class_name Bullet

var bullet_radius: float = 0.25
var damage: int = 10
var speed: float = 30.0
var despawn_time: float = 5.0
var type = ENEMY
enum {
	ENEMY,
	PLAYER
}
@onready var area: Area3D = get_node('Area3D')
@onready var timer: Timer = Timer.new()

@onready var area_collision: CollisionShape3D = get_node('Area3D').get_node('CollisionShape3D')
@onready var mesh: MeshInstance3D = get_node('MeshInstance3D')


signal deactivate()
signal activate()
var is_activated: bool = false

func _ready() -> void:
	_set_bullet_radius(bullet_radius)
	area.connect('body_entered', on_body_entered)
	area.connect('area_entered', on_area_entered)
	timer.connect('timeout', on_timer_timeout)
	top_level = true
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)

	connect('deactivate', on_deactivate)
	connect('activate', on_activate)
	on_deactivate()


func _process(_delta: float) -> void:
	if is_activated:
		linear_velocity = - transform.basis.z * speed
	else:
		linear_velocity = Vector3.ZERO


func on_area_entered(_area: Area3D) -> void:
	if _area.get_parent() is Bullet:
		# call_deferred('queue_free')
		pass


func on_body_entered(body: Node3D) -> void:
	match type:
		PLAYER:
			# if body.is_in_group('enemy'):
			# 	if body.has_method('take_damage'):
			# 		body.take_damage(damage)
			# 	call_deferred('queue_free')
			# elif body is StaticBody3D:
			# 	call_deferred('queue_free')
			# elif body.is_in_group('player'):
			# 	pass
			# else:
			# 	call_deferred('queue_free')
			pass

		ENEMY:
			if body.is_in_group('player') and is_activated:
				if body.has_method('take_damage'):
					body.take_damage(damage)
				
				emit_signal('deactivate')
			elif body is StaticBody3D and is_activated:
				emit_signal('deactivate')
				pass

		_:
			pass

func on_deactivate() -> void:
	visible = false
	is_activated = false
	global_position = get_parent().global_position
	pass


func on_activate() -> void:
	
	visible = true
	is_activated = true
	timer.start(despawn_time)
	
	pass

## cuando se acaba timer la bala se desactiva
func on_timer_timeout() -> void:
	emit_signal('deactivate')
	pass


func _set_bullet_radius(radius: float) -> void:
	area_collision.shape = area_collision.shape.duplicate()
	(area_collision.shape as SphereShape3D).radius = radius

	mesh.mesh = mesh.mesh.duplicate()
	(mesh.mesh as SphereMesh).radius = radius
	(mesh.mesh as SphereMesh).height = radius * 2
