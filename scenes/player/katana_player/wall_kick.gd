extends State

@onready var sm:StateMachine = get_parent()
@onready var timer:Timer = Timer.new()

func _ready() -> void:
    add_child(timer)
    timer.one_shot = true
    timer.autostart = false

func enter() -> void:
    print(name)
    timer.start(0.3)


func physics_process(_delta: float) -> void:
    _change_state_to()

    sm.parent.velocity.y = 10
    sm.parent.velocity.x = sm.parent.last_direction.x * -1.5
    sm.parent.velocity.z = sm.parent.last_direction.z * -1.5

func exit() -> void:
    sm.last_state = sm.states['wallkick']

    
func _change_state_to()-> void:
    if not timer.time_left as bool:
        emit_signal('change_state_to', self, 'air')
    pass
