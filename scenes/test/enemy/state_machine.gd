extends Node
class_name StateMachine

@export var player:PlayerBody
@onready var parent:BaseEnemy = get_parent()
@onready var nav:NavigationAgent3D = parent.get_node("NavigationAgent3D")
var current_state: int = 0

var debug_timer = 0.0

enum STATES {
	WANDERING,
	CHASE,
}


# current_state init
func _ready() -> void:
	player = get_tree().get_first_node_in_group('player')
	enter(STATES.WANDERING)



func _physics_process(_delta: float) -> void:
	state_machine(_delta)
	if Input.is_action_just_pressed("right_mb"):
		enter(STATES.CHASE)

	


## Entrar a enum STATES {WANDERING,CHASE,}
func enter(state: int = STATES.WANDERING) -> void:
	current_state = state
	pass


#checar current_state
func state_machine(_delta) -> void:
	match current_state:
		STATES.WANDERING:
			pass
		STATES.CHASE:
			nav.set_target_position(player.global_position)
			var destination = nav.get_next_path_position()
			var direction = destination - parent.global_position
			direction = direction.normalized()
			parent.velocity = direction * parent.speed
			parent.look_at(Vector3(player.global_position.x, parent.global_position.y, player.global_position.z))
			parent.move_and_slide()

			debug_timer += _delta
			if debug_timer >= 1.0:
				print(parent.velocity)
				debug_timer = 0.0
			

			pass
			
		_:
			pass
		#invocar metodo desde el nodo de el state adecuado
