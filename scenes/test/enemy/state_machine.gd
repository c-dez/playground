extends Node
class_name StateMachine


var current_state = null
enum STATE {
	WANDERING,
	CHASE,
}


# current_state init
func _ready() -> void:
	enter(STATE.WANDERING)


## Entrar a enum STATE {WANDERING,CHASE,}
func enter(state: int = STATE.WANDERING) -> void:
	current_state = state
	pass


#checar current_state
func state_machine() -> void:
	match current_state:
		STATE.WANDERING:
			pass
		STATE.CHASE:
			pass
			
		_:
			pass
		#invocar metodo desde el nodo de el state adecuado