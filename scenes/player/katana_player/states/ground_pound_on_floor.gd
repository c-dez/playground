extends State

# estado intermedio entre ground pound y otros segun acciones de player
# @onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
var state_duration_time: float = 0.3
var jump_multiplier: float = 1

signal enter_state_signal()

func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false


func enter() -> void:
	# print(name)
	timer.start(state_duration_time)
	sm.parent.mesh.do_squash_and_stretch(0.5, 0.10)
	emit_signal('enter_state_signal')

	#ground_pound_hitbox
	sm.parent.ground_pound_hitbox.global_position = sm.parent.global_position
	sm.parent.ground_pound_hitbox.set_monitorable(true)

	await get_tree().create_timer(0.2).timeout
	sm.parent.ground_pound_hitbox.set_monitorable(false)


func process(_delta: float) -> void:
	_change_state_to()
	pass

func physics_process(_delta: float) -> void:
	if PlayerInput.jump_button():
		sm.parent.velocity.y = sm.parent._jump_velocity * jump_multiplier
		await get_tree().create_timer(0.2).timeout

		emit_signal('change_state_to', self, 'air')
		pass
	pass


func exit() -> void:
	# sm.last_state = self
	timer.stop()


func _change_state_to() -> void:
	if not timer.time_left as bool:
		emit_signal('change_state_to', self, 'move')
	
	if PlayerInput.light_attack_button():
		emit_signal('change_state_to', self,'attack')
		pass
