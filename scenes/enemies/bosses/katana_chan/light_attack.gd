extends Attack
class_name katanaAttack
var _attack_cooldown:= 5.0

func enter() -> void:
    parent.velocity = Vector3.ZERO
    attack_cooldown = _attack_cooldown
    print(name)

func process(_delta: float) -> void:
    attack(_delta)



func _change_state_to()-> void:
    emit_signal("change_state_to", self, 'idle')


func attack(_delta:float) ->void:
    attack_cooldown -= _delta
    if attack_cooldown < 0:
        _change_state_to()

    pass