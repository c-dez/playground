extends State

# moverse hacia jugador

func physics_process(_delta: float) -> void:
    sm.parent.move()
