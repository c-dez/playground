extends State

@onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
var timer_start_time: float = 1.0
var jump_multiplier: float = 1.3

func _ready() -> void:
    add_child(timer)
    timer.one_shot = true
    timer.autostart = false


func enter() -> void:
    # print(name)
    timer.start(timer_start_time)
    sm.parent.mesh.do_squash_and_stretch(0.5, 0.10)


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
    sm.last_state = self
    timer.stop()


func _change_state_to() -> void:
    if not timer.time_left as bool:
        emit_signal('change_state_to', self, 'move')
        pass
