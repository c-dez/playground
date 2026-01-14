extends RigidBody3D
class_name Bullet

var damage: int = 10
var speed: float = 50.0
@onready var area: Area3D = get_node('Area3D')
@onready var timer: Timer = Timer.new()
var despawn_time: int = 10
var type = ENEMY
enum {
	ENEMY,
	PLAYER
}

func _ready() -> void:
	area.connect('body_entered', on_body_entered)
	top_level = true

	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.connect('timeout', on_timer_timeout)
	timer.start(despawn_time)


func _process(_delta: float) -> void:
	linear_velocity = - transform.basis.z * speed


func on_body_entered(body: Node3D) -> void:
	if body.is_in_group('enemy'):
		queue_free()
		match type:
			PLAYER:
				if body.is_in_group('enemy'):
					body.stats.health -= damage
					print(body.stats.health)
			ENEMY:
				if body.is_in_group('enemy'):
					print(body.name)
			_:
				pass
		
	


func on_timer_timeout() -> void:
	call_deferred('queue_free')
	print('time')