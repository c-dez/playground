extends State

@onready var sm: StateMachine = get_parent()
@onready var timer: Timer = Timer.new()
var timer_time: float = 0.5
var enter_velocity: Vector3
var speed_multiplier: float = 2.5

func _ready() -> void:
    add_child(timer)
    timer.one_shot = true
    timer.autostart = false
    timer.connect('timeout', on_timer_timeout)


func enter() -> void:
    print(name)
    timer.start(timer_time)
    enter_velocity = sm.parent.velocity
    sm.parent.velocity = enter_velocity * speed_multiplier


func process(_delta: float) -> void:
    _change_state_to()


func physics_process(_delta: float) -> void:
    sm.parent.mesh.scale.y = 0.7
   

func exit() -> void:
    # sm.last_state = self
    timer.stop()
    sm.parent.mesh.scale.y = 1
    sm.parent.velocity = enter_velocity


func on_timer_timeout() -> void:
        emit_signal('change_state_to', self , 'move')


func _change_state_to() -> void:
    # if Input.is_action_just_pressed(PlayerInput.BUTTONS['space']):
    if PlayerInput.jump_button():
        emit_signal('change_state_to', self , 'slidejump')