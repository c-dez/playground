extends State
class_name EnemyChaseState

var nav: NavigationAgent3D


func _ready() -> void:
    await owner.ready
    nav = owner.navigation
    nav.connect('navigation_finished', on_navigation_finished)
    pass


func enter() -> void:
    print(self )
    _check_time = CHECK_TIME


    pass


var direction = Vector3.ZERO
const CHECK_TIME = 0.5
var _check_time = CHECK_TIME
func physics_process(_delta: float) -> void:
    _check_time -= _delta
    if _check_time < 0:
        # if nav.is_navigation_finished():
        #     owner.velocity = Vector3.ZERO
        #     return
        nav.target_position = owner.player.global_position

        var next_pos = nav.get_next_path_position()
        direction = (next_pos - owner.global_position).normalized()

        # print(nav.is_target_reachable())
        if owner.global_position.distance_to(owner.player.global_position)< owner.attack_range:
            emit_signal('change_state_to', self, 'attack')
        _check_time = CHECK_TIME

    owner.move(direction, owner.chase_speed)
    pass

    
func on_navigation_finished() -> void:
    emit_signal('change_state_to', self , 'attack')
