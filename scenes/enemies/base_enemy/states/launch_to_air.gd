extends State


func enter() -> void:
    print(self,' state')
    # sm.parent.velocity.y = 200



func physics_process(_delta: float) -> void:
    # sm.parent.gravity(10)
    sm.parent.velocity.y += 10 * _delta
    pass