extends State
class_name Attack

@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')
@onready var parent: Enemy = get_parent().get_parent()
@onready var bullet: PackedScene = preload('res://components/bullet/bullet.tscn')
var attack_cooldown: float
var check_state_time: float
var _check_state_time: float = 1.0

## almacena bullets para hacer object_pooling
@onready var bullets_node: Node3D = get_node("Bullets")


func _ready() -> void:
	for i in range(10):
		var b = bullet.instantiate()
		b.name = 'Bullet%s' % [i]

		bullets_node.add_child(b)


func enter() -> void:
	parent.velocity = Vector3.ZERO
	attack_cooldown = parent.stats.attack_cooldown
	pass

func process(_delta: float) -> void:
	# attack
	attack(_delta)
	# checar cuando se debe de cambiar de state
	check_state_time -= _delta
	if check_state_time < 0:
		_change_state_to()
		check_state_time = _check_state_time
	pass

func physics_process(_delta) -> void:
	parent.get_node('MeshInstance3D').look_at(player.global_position)
	parent.get_node('Muzzle').look_at(player.global_position)


func attack(_delta) -> void:
	attack_cooldown -= _delta
	if attack_cooldown < 0:
		for i in bullets_node.get_child_count():
			var item := bullets_node.get_child(i)
			if item.is_activated == false:
				item.global_position = parent.muzzle.global_position
				item.on_activate()
				item.look_at(player.global_position)
				break

		attack_cooldown = parent.stats.attack_cooldown

func _change_state_to() -> void:
	#chase
	if parent.global_position.distance_to(player.global_position) > parent.stats.attack_range:
		emit_signal('change_state_to', self, 'chase')
	# chase if cant see player
	elif parent.muzzle.ray.is_colliding():
		var target = parent.muzzle.ray.get_collider()
		if target is not PlayerBody:
			emit_signal('change_state_to', self, 'chase')
