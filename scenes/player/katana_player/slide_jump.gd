extends State


@onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
var timer_time: float = 1.0

func _ready() -> void:
    add_child(timer)
    timer.one_shot = true
    timer.autostart = false
    # timer.connect('timeout', on_timer_timeout)

func enter() -> void:
    print(name)