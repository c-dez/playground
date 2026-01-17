extends State
class_name Attack

@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')
@onready var parent: Enemy = get_parent().get_parent()
@onready var bullet: PackedScene = preload('res://components/bullet/bullet.tscn')
var attack_cooldown: float

func enter() -> void:
	parent.velocity = Vector3.ZERO
	attack_cooldown = parent.stats.attack_cooldown
	pass

func process(_delta: float) -> void:
	# shoot
	shoot(_delta)
	# checar cuando se debe de cambiar de state
	_change_state_to()
	pass

func physics_process(_delta) -> void:

	parent.get_node('MeshInstance3D').look_at(player.global_position)


func shoot(_delta) -> void:
	attack_cooldown -= _delta
	if attack_cooldown < 0:
		var b = bullet.instantiate()
		b.bullet_radius = 0.25
		b.type = b.ENEMY
		b.damage = parent.stats.damage
		parent.muzzle.add_child(b)
		attack_cooldown = parent.stats.attack_cooldown
		b.look_at(player.global_position)


func _change_state_to() -> void:
	#chase
	if parent.global_position.distance_to(player.global_position) > parent.stats.attack_range:
		emit_signal('change_state_to', self, 'chase')
	# chase if cant see player
	elif parent.muzzle.ray.is_colliding():
		var target = parent.muzzle.ray.get_collider()
		if target is not PlayerBody:
			emit_signal('change_state_to', self, 'chase')
