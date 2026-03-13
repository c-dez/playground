extends State

var enemies_inside_attack_area_list
var attack_duration: float = 0.5
@onready var timer: Timer = Timer.new()

## senal emitida al entrar al state
signal enter_state_signal()


func _ready():
	add_child(timer)
	timer.connect('timeout', on_timeout)


func enter() -> void:
	timer.start(attack_duration)
	emit_signal('enter_state_signal')

	sm.parent.hitbox.set_monitorable(true)
	await get_tree().create_timer(0.2).timeout
	sm.parent.hitbox.set_monitorable(false)


func physics_process(_delta: float) -> void:
	move(_delta)
	do_damage()


func exit() -> void:
	timer.stop()


func do_damage() -> void:
	if enemies_inside_attack_area_list != null:
		for item in enemies_inside_attack_area_list:
			if item.has_method('take_damage'):
				item.take_damage(sm.parent.stats.damage)
		enemies_inside_attack_area_list = null


func on_timeout() -> void:
	emit_signal('change_state_to', self , 'move')


var speed_multiplier: float = 0.8
func move(delta) -> void:
	var input_dir := PlayerInput.get_direction()
	var direction := (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		sm.parent.velocity.x = direction.x * sm.parent.stats.move_speed * speed_multiplier
		sm.parent.velocity.z = direction.z * sm.parent.stats.move_speed * speed_multiplier

		sm.parent.rotate_mesh(direction, delta)
	else:
		sm.parent.velocity.x = move_toward(sm.parent.velocity.x, 0, sm.parent.stats.move_speed)
		sm.parent.velocity.z = move_toward(sm.parent.velocity.z, 0, sm.parent.stats.move_speed)
