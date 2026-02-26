extends State

@onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
var wall_normal
var input_dir: Vector2
var direction: Vector3
var speed: int = 10
var jump_force: int = 12


func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false


func enter() -> void:
	# print(name)
	timer.start(0.3)
	wall_normal = sm.parent.wall_normal
	input_dir = PlayerInput.get_direction()
	direction = (sm.parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


func physics_process(_delta: float) -> void:
	_change_state_to()
	if not sm.parent.wall_normal == null:
		if direction:
			sm.parent.velocity = direction.bounce(sm.parent.wall_normal) * speed
			sm.parent.velocity.y = jump_force
		else:
			var forward = sm.parent.mesh.transform.basis.z.normalized()

			sm.parent.velocity = forward.bounce(sm.parent.wall_normal) * speed
			sm.parent.velocity.y = jump_force


func exit() -> void:
	sm.last_state = sm.states['wallkick']


func _change_state_to() -> void:
	if not timer.time_left as bool:
		emit_signal('change_state_to', self, 'air')
	pass
