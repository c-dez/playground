extends Area3D
class_name DamageArea

var damage: int = 5
@onready var collision: CollisionShape3D = get_node('CollisionShape3D')
@onready var decal: Decal = get_node('Decal')
@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')
# damage_timer
@onready var damage_timer: Timer = Timer.new()
var damage_timer_time: float = 1
# duration_timer
@onready var duration_timer: Timer = Timer.new()
var duration_timer_time: float = 10.0
# activation_timer
@onready var activation_timer: Timer = Timer.new()
var activation_timer_time: float = 2.0
var is_area_damage_active: bool = false


var area_size: Vector3

func _ready() -> void:
	top_level = true
	# damage_timer
	add_child(damage_timer)
	damage_timer.one_shot = false
	damage_timer.autostart = false
	damage_timer.connect('timeout', on_damage_timer_timeout)
	# duration_timer
	add_child(duration_timer)
	duration_timer.autostart = true
	duration_timer.one_shot = true
	duration_timer.start(duration_timer_time)
	duration_timer.connect('timeout', on_duration_timer_timeout)
	#activation_timer
	add_child(activation_timer)
	activation_timer.autostart = true
	activation_timer.one_shot = true
	activation_timer.start(activation_timer_time)
	activation_timer.connect('timeout', on_activation_timer_timeout)

	#area signals
	connect('body_entered', on_player_entered)
	connect('body_exited', on_player_exited)

	position = player.global_position
	var player_height: float = 1.5
	position.y = player.global_position.y - player_height



func _physics_process(_delta: float) -> void:
	pass


func on_player_entered(body: Node3D) -> void:
	if body is PlayerBody and is_area_damage_active:
		damage_timer.start(damage_timer_time)
	pass


func on_player_exited(body: Node3D) -> void:
	if body is PlayerBody:
		damage_timer.stop()

func on_damage_timer_timeout() -> void:
	player.take_damage(damage)
	print(damage)


func on_duration_timer_timeout() -> void:
	call_deferred('queue_free')
	# queue_free()


func on_activation_timer_timeout() -> void:
	is_area_damage_active = true
	decal.modulate = Color.RED
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			if body is PlayerBody:
				damage_timer.start(damage_timer_time)
				var explosion_damage := 20
				body.take_damage(explosion_damage)
	pass
