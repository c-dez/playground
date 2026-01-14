extends State
class_name Attack

@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')
@onready var parent: Enemy = get_parent().get_parent()


func enter() -> void:
	print(parent)
	parent.velocity = Vector3.ZERO
	pass

func process(_delta: float) -> void:
	# muzzle/ raycast debe mirar a jugador
	# shoot
	# checar cuando se debe de cambiar de state
		# y a que state
	pass

func physic_process(_delta):
	# parent.muzzle.look_at(player.global_position)
	pass

func shoot() -> void:
	# disparar cada intervalo de tiempo
	# bullet.gd extenderlo para que se pueda reusar con enemigos
		# darle una propiedad de a quien pertenece( player/enemigo)
		# poder cambiar el tanano de mesh y collision de bala
	pass
