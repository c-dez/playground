extends State

var attack_area: Area3D = null
var enemies_inside_attack_area_list
@onready var sm: StateMachine = get_parent()
@onready var timer := Timer.new()


func _ready():
	add_child(timer)
	timer.connect('timeout', on_timeout)

	await get_tree().create_timer(0.1).timeout
	attack_area = sm.parent.attack_area
	if attack_area == null:
		printerr('attack_area is null')


func enter() -> void:
	timer.start(0.5)
	# print(self )
	# attack_area as Area3D 
	attack_area.set_monitoring(true)
	pass


func process(_delta: float) -> void:
	# print(sm.parent.attack_area.monitoring)
	pass


func physics_process(_delta: float) -> void:
	move(_delta)
	
	if attack_area.is_monitoring():
		if attack_area.has_overlapping_bodies():
			enemies_inside_attack_area_list = attack_area.get_overlapping_bodies()
			attack_area.set_monitoring(false)
		else:
			enemies_inside_attack_area_list = null


	if enemies_inside_attack_area_list != null:
		for item in enemies_inside_attack_area_list:
			if item.has_method('take_damage'):
				item.take_damage(sm.parent.stats.damage)
				enemies_inside_attack_area_list = null


func exit() -> void:
	sm.last_state = self
	timer.stop()
	attack_area.set_monitoring(false)


func on_timeout() -> void:
	emit_signal('change_state_to', self , 'move')


func move(delta) -> void:
	var input_dir := PlayerInput.get_direction()
	var direction := (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		sm.parent.velocity.x = direction.x * sm.parent.stats.move_speed
		sm.parent.velocity.z = direction.z * sm.parent.stats.move_speed

		sm.parent.rotate_mesh(direction, delta)
	else:
		sm.parent.velocity.x = move_toward(sm.parent.velocity.x, 0, sm.parent.stats.move_speed)
		sm.parent.velocity.z = move_toward(sm.parent.velocity.z, 0, sm.parent.stats.move_speed)
