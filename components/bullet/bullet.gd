extends RigidBody3D
class_name Bullet

var bullet_radius: float = 0.25
var damage: int = 10
var speed: float = 30.0
@onready var area: Area3D = get_node('Area3D')
@onready var timer: Timer = Timer.new()
var despawn_time: float = 10.0
var type = ENEMY
enum {
	ENEMY,
	PLAYER
}


@onready var area_collision: CollisionShape3D = get_node('Area3D').get_node('CollisionShape3D')
@onready var mesh: MeshInstance3D = get_node('MeshInstance3D')


func _ready() -> void:
	_set_bullet_radius(bullet_radius)
	area.connect('body_entered', on_body_entered)
	area.connect('area_entered', on_area_entered)
	timer.connect('timeout', on_timer_timeout)
	top_level = true
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.start(despawn_time)


	
func _process(_delta: float) -> void:
	linear_velocity = - transform.basis.z * speed


func on_area_entered(_area: Area3D):
	if _area.get_parent() is Bullet:
		call_deferred('queue_free')

func on_body_entered(body: Node3D) -> void:
	match type:
		PLAYER:
			if body.is_in_group('enemy'):
				body.stats.health -= damage
				print(body.name, ' enemy')
				call_deferred('queue_free')
			elif body is StaticBody3D:
				print(body.name)
				call_deferred('queue_free')
			elif body.is_in_group('player'):
				pass
			else:
				call_deferred('queue_free')


		ENEMY:
			if body.is_in_group('player'):
				print(body.name)
				call_deferred('queue_free')

		_:
			pass
		
	# call_deferred('queue_free')


func on_timer_timeout() -> void:
	call_deferred('queue_free')


func _set_bullet_radius(radius: float) -> void:
	# var mesh_shape = mesh.mesh as SphereMesh
	# mesh_shape.radius = radius
	# mesh_shape.height = radius * 2
	# var area_shape = area_collision.shape as SphereShape3D
	# area_shape.radius = radius + 0.05
	area_collision.shape = area_collision.shape.duplicate()
	(area_collision.shape as SphereShape3D).radius = radius

	mesh.mesh = mesh.mesh.duplicate()
	(mesh.mesh as SphereMesh).radius = radius
	(mesh.mesh as SphereMesh).height = radius * 2
