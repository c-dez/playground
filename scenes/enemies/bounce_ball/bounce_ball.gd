extends StaticBody3D


## despawn-> al ser golpeado, desaparece y se vuelve a activar despues de x tiempo
@export var on_hit_behavior: ON_HIT_BEHAVIOR = ON_HIT_BEHAVIOR.permanent
@export var despawn_time: float = 3

@onready var timer := Timer.new()

enum ON_HIT_BEHAVIOR {
	despawn,
	permanent
}
@onready var hurtbox: Area3D = get_node('BounceBallHurtbox')

func _ready() -> void:
	_timer_set_up()
	pass


## Cuando es atacada por Player
func is_hit_behavior() -> void:
	match on_hit_behavior:
		ON_HIT_BEHAVIOR.despawn:
			timer.start(despawn_time)
			toggle_active()
		_:
			pass
	pass


func _timer_set_up() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.connect('timeout', on_timer_timeout)


func on_timer_timeout() -> void:
	toggle_active()


func toggle_active() -> void:
	var test = !hurtbox.is_monitorable()
	visible = test
	hurtbox.toggle_monitoring()




