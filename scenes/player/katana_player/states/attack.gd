extends State

#attack state katana_player

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
	# me gusta que brinque al golpear enemigo cuando player esta en el aire, junto con ground_pound se siente interesante de jugar , pero no estoy seguro como encaja en el gameplay de combate
	if hurtbox.owner.has_method('take_damage'):
		if not sm.parent.is_on_floor():
			sm.parent.velocity.y = 20


func enter() -> void:
	timer.start(attack_duration)
	emit_signal('enter_state_signal')

	attack_hitbox.set_monitorable(true)
	attack_hitbox.set_monitoring(true)
	await get_tree().create_timer(0.2).timeout
	attack_hitbox.set_monitorable(false)
	attack_hitbox.set_monitoring(false)


func physics_process(_delta: float) -> void:
	
	sm.parent.gravity(_delta)
	
	sm.parent.move(_delta, 1)
	pass


func exit() -> void:
	timer.stop()


func on_timeout() -> void:
	emit_signal('change_state_to', self , 'move')
