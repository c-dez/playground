extends State
class_name Attack

@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')

var parent: Enemy

func enter() -> void:
    if parent == null:
        parent = get_parent().parent

func process(_delta: float) -> void:
    # muzzle/ raycast debe mirar a jugador
    # shoot
    # checar cuando se debe de cambiar de state
        # y a que state


    parent.velocity = Vector3.ZERO


func shoot() -> void:
    # disparar cada intervalo de tiempo
    # bullet.gd extenderlo para que se pueda reusar con enemigos
        # darle una propiedad de a quien pertenece( player/enemigo)
        # poder cambiar el tanano de mesh y collision de bala
    pass

