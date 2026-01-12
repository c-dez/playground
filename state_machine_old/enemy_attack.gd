extends State
class_name EnemyAttack

@onready var enemy: BaseEnemy = get_parent().get_parent()
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group('player')


func process(_delta:float)-> void:
	if enemy.global_position.distance_to(player.global_position) > enemy.stats.attack_range:
		emit_signal('transitioned',self,'EnemyChase')
