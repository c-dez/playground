extends State
class_name EnemyIdleState


@onready var state_duration_timer := Timer.new()
var duration_time: float = 1.0


func _ready() -> void:
    _set_state_duration_timer_propeties()


func enter() -> void:
    state_duration_timer.start(duration_time)
    # print(self)
    owner.velocity = Vector3.ZERO


func exit() -> void:
    state_duration_timer.stop()


func _set_state_duration_timer_propeties() -> void:
    add_child(state_duration_timer)
    state_duration_timer.autostart = false
    state_duration_timer.one_shot = true
    state_duration_timer.connect('timeout', _on_state_duration_timer)


func _on_state_duration_timer() -> void:
    var current_pos: Vector3 = owner.global_position
    var player_pos: Vector3 = owner.player.global_position
    var chase_range: float = owner.chase_range
    var attack_range = owner.attack_range
    if current_pos.distance_to(player_pos) < attack_range:
        emit_signal('change_state_to', self , 'attack')
    elif current_pos.distance_to(player_pos) < chase_range:
        emit_signal('change_state_to', self , 'chase')
    else:
        state_duration_timer.start(duration_time)
    pass
