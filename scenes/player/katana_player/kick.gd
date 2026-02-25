extends State


@onready var sm: StateMachine = get_parent()

func enter() -> void:
    print(name)
    pass

func physics_process(_delta: float) -> void:
    _change_state_to()


func _change_state_to() -> void:
    if sm.parent.is_on_floor():
        emit_signal('change_state_to', self, 'move')
