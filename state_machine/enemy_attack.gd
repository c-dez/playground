extends State
class_name EnemyAttack


func process(_delta:float)-> void:
	if enemy.global_position.distance_to(player.global_position) > enemy.stats.attack_range:
		emit_signal('transitioned',self,'EnemyChase')
