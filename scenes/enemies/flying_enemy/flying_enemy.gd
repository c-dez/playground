extends Enemy
class_name FlyingEnemy

func _physics_process(_delta: float) -> void:
    move_and_slide()
    pass
