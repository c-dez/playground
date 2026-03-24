extends State
class_name EnemyChaseState

# var navigation = owner.navigation
var nav: NavigationAgent3D
var target


func _ready() -> void:
    target = get_tree().get_first_node_in_group('player')
    pass


func enter() -> void:
    nav = owner.navigation
    print(nav)
    pass


var direction = Vector3.ZERO
const check_time = 1
var _check_time = check_time
func physics_process(_delta: float) -> void:
    _check_time -= _delta
    if _check_time < 0:
        # if nav.is_navigation_finished():
        #     owner.velocity = Vector3.ZERO
        #     return
        print(_check_time)
        nav.target_position = target.global_position

        var next_pos = nav.get_next_path_position()
        direction = (next_pos - owner.global_position).normalized()

        _check_time = check_time

    owner.move(direction, owner.chase_speed)
    pass
