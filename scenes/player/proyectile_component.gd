extends Node3D
## usado para que player dispare
class_name ProyectileComponent


var max_bullets: int = 6
var current_bullets: int
@onready var ray: RayCast3D = get_node('RayCast3D')
@onready var bullet: PackedScene = preload('res://components/bullet/bullet.tscn')
@onready var camera: Camera3D = get_parent().get_node('PlayerCamera')
@onready var muzzle: Marker3D = camera.get_node('Muzzle')
@onready var player: CharacterBody3D = get_parent()
signal current_bullets_update(current_bullets: int)

# reload
var _reload_time_per_bullet: float = 0.3
var _is_reloading: bool = false
@onready var _reload_timer: Timer = Timer.new()


func _ready() -> void:
	add_child(_reload_timer)
	_reload_timer.one_shot = true
	_reload_timer.autostart = false
	_reload_timer.connect('timeout', on_reload_timer_timeout)

	current_bullets = max_bullets


func _process(_delta: float) -> void:
	_set_position()
	reload(_delta)


func _physics_process(_delta: float) -> void:
	shoot()


func shoot() -> void:
	if ray.is_colliding():
		if Input.is_action_just_pressed('left_mb') and current_bullets > 0:
			if _is_reloading == false:
				current_bullets -= 1
				emit_signal('current_bullets_update', current_bullets)
				var target := ray.get_collider()

				if target is Enemy:
					target.take_damage(player.stats.damage)
				
				
		# 		var target := ray.get_collision_point()

		# 		var b := bullet.instantiate()
		# 		b.damage = player.stats.damage
		# 		b.bullet_radius = 0.1
		# 		b.type = b.PLAYER
		# 		b.damage = player.stats.damage
		# 		muzzle.add_child(b)
		# 		b.look_at(target, Vector3.UP)


func reload(_delta) -> void:
	if current_bullets == 0:
		if Input.is_action_just_pressed('r_key') or Input.is_action_just_pressed('left_mb'):
			print('reload')
			_is_reloading = true
			_reload_timer.start(_reload_time_per_bullet)


func on_reload_timer_timeout() -> void:
	current_bullets += 1
	emit_signal('current_bullets_update', current_bullets)
	if current_bullets < max_bullets:
		_reload_timer.start(_reload_time_per_bullet)
	elif current_bullets == max_bullets:
		_is_reloading = false


func _set_position() -> void:
	position = camera.position
	rotation = camera.rotation
