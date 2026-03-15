extends State

var enemies_inside_attack_area_list
var attack_duration: float = 0.5
@onready var timer: Timer = Timer.new()
@onready var attack_hitbox: Hitbox = owner.get_node('AttackHitbox')

## senal emitida al entrar al state
signal enter_state_signal()


func _ready():
	add_child(timer)
	timer.connect('timeout', on_timeout)
	
	# cuando lo golpea y el enemigo esta en el aire
	attack_hitbox.connect('area_entered', on_attack_hitbox_area_entered)


func on_attack_hitbox_area_entered(hurtbox: Hurtbox):
	# cuando lo golpea y el enemigo esta en el aire
	# cambiar a state apropiado de golpeando en aire
	if not hurtbox.owner.is_on_floor():
		print(hurtbox.owner.sm.current_state)


func enter() -> void:
	timer.start(attack_duration)
	emit_signal('enter_state_signal')

	attack_hitbox.set_monitorable(true)
	attack_hitbox.set_monitoring(true)
	await get_tree().create_timer(0.2).timeout
	attack_hitbox.set_monitorable(false)
	attack_hitbox.set_monitoring(false)


func physics_process(_delta: float) -> void:
	sm.parent.move(_delta, 1)


func exit() -> void:
	timer.stop()


func on_timeout() -> void:
	emit_signal('change_state_to', self , 'move')
