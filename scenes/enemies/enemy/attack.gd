extends State
class_name EnemyAttack


@onready var timer := Timer.new()


func _ready() -> void:
    add_child(timer)
    timer.one_shot = true
    timer.autostart = false
    timer.connect('timeout', on_timer_timeout)


func enter() -> void:
    # timer.start(1)
    print(self )

    # seleccionar ataque?



func physics_process(_delta: float) -> void:
    owner.velocity = Vector3.ZERO
    # ejecutar ataque


func exit() -> void:
    # regresar a idle?
    pass


func on_timer_timeout() -> void:
    emit_signal('change_state_to', self, 'idle')

func _select_attack() -> int:
    var attack:int = 0

    return attack