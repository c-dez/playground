extends State

@onready var timer := Timer.new()
var state_duration_time: float = 1


func _ready() -> void:
    _set_timer_propeties()

func enter() -> void:
    # print('last state ' , sm.last_state.name.to_lower())
    timer.start(state_duration_time)

func physics_process(_delta: float) -> void:
    sm.parent.velocity.y = 0


func exit() -> void:
    timer.stop()


func on_timer_timeout() -> void:
    # print(str(sm.last_state.name).to_lower())
    emit_signal('change_state_to', self , 'idle')


func _set_timer_propeties() -> void:
    add_child(timer)
    timer.one_shot = true
    timer.autostart = false
    timer.connect('timeout', on_timer_timeout)
