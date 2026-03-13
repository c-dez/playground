extends State


# @onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
var timer_time: float = 0.5
var jump_multiplier: float = 1.5

func _ready() -> void:
    add_child(timer)
    timer.one_shot = true
    timer.autostart = false
    timer.connect('timeout', on_timer_timeout)


func enter() -> void:
    timer.start(timer_time)
    print(name)
    sm.parent.velocity.y = sm.parent._jump_velocity * jump_multiplier


# func exit() -> void:
#     sm.last_state = self


func on_timer_timeout() -> void:
    emit_signal('change_state_to', self , 'move')
    pass

func _change_state_to() -> void:
    pass