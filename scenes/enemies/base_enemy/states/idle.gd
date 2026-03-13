extends State

@onready var timer := Timer.new()


func _ready() -> void:
    add_child(timer)
    timer.one_shot = true
    timer.autostart = false
    timer.connect('timeout', _on_timer_timeout)


func enter() -> void:
    timer.start(1)


func exit() -> void:
    timer.stop()


func _on_timer_timeout() -> void:
    emit_signal('change_state_to', self, 'move')
    pass