extends State
class_name EnemyIdleState

@onready var state_duration_timer := Timer.new()
var duration_time: float = 1.0


func _ready() -> void:
    _set_state_duration_timer_propeties()
    pass


func enter() -> void:
    state_duration_timer.start(duration_time)


func exit() -> void:
    state_duration_timer.stop()


func _set_state_duration_timer_propeties() -> void:
    add_child(state_duration_timer)
    state_duration_timer.autostart = false
    state_duration_timer.one_shot = true
    state_duration_timer.connect('timeout', on_state_duration_timer)


func on_state_duration_timer() -> void:
    emit_signal('change_state_to', self, 'chase')
    pass
