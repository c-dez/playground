extends Node
class_name StateMachine

## States wandering, chase_player
@export var player_reference: PlayerBody
@onready var parent: BaseEnemy = get_parent()
@onready var nav: NavigationAgent3D = parent.get_node("NavigationAgent3D")

var current_state: int = 0
enum STATES {
	WANDERING,
	CHASE,
}


func _ready() -> void:
	player_reference = _get_player()
	enter(0 as STATES)


func _physics_process(_delta: float) -> void:
	state_machine(_delta)
	# debug
	# if Input.is_action_just_pressed("right_mb"):
	# 	enter(STATES.CHASE)
	detect_player()


func detect_player():
	if parent.global_position.distance_to(player_reference.global_position) < parent.detection_range:
		enter(1 as STATES)
	else:
		enter(0 as STATES)
	
## Entrar a enum STATES {WANDERING,CHASE,}
func enter(state: int = 0 as STATES) -> void:
	current_state = state


#checar current_state
func state_machine(_delta) -> void:
	match current_state:
		0 as STATES:

			pass

		1 as STATES:
			nav.set_target_position(player_reference.global_position)
			var destination = nav.get_next_path_position()
			var direction = destination - parent.global_position
			direction = direction.normalized()
			parent.velocity = direction * parent.stats.move_speed
			var player_position = Vector3(player_reference.global_position.x, parent.global_position.y, player_reference.global_position.z)
			parent.look_at(player_position)
			parent.move_and_slide()

		_:
			print('no state')


func _get_player() -> PlayerBody:
	return get_tree().get_first_node_in_group('player')