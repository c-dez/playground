extends State


func enter() -> void:
    print(self)

func physics_process(_delta: float) -> void:
    sm.parent.velocity.y = 0