extends State

@onready var timer := Timer.new()
var duration_time: float = 1.0


func _ready() -> void:
    _set_timer_propeties()

func enter() -> void:
    # print(self , ' state')
    timer.start(duration_time)


func physics_process(_delta: float) -> void:
    # sm.parent.gravity(10)
    sm.parent.velocity.y += 10 * _delta
    pass

func exit() -> void:
    timer.stop()

func _change_state_to()-> void:
    pass


func _on_timer_timeout() -> void:
    emit_signal('change_state_to', self , 'idle')


func _set_timer_propeties() -> void:
    add_child(timer)
    timer.autostart = false
    timer.one_shot = true
    timer.connect('timeout', _on_timer_timeout)
