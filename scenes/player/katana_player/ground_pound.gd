extends State

#  ground pound


var drop_speed: int = 25
@onready var sm: StateMachine = get_parent()

signal ground_pound_area_signal()


func enter() -> void:
    # print(name)
    pass

func process(_delta: float) -> void:
    pass

func physics_process(_delta: float) -> void:
    sm.parent.velocity.y = - drop_speed
    sm.parent.velocity.x = 0
    sm.parent.velocity.z = 0
    _change_state_to()

func exit() -> void:
    sm.last_state = self


func _change_state_to() -> void:
    if sm.parent.is_on_floor():
        emit_signal('change_state_to', self , 'groundpoundonfloor')
        # signal de dano en area en el suelo
        emit_signal('ground_pound_area_signal')
