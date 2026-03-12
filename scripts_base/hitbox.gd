extends Area3D
class_name Hitbox

## state desde que se escucha enter_state_signal
@export var state: State
@export var parent: CharacterBody3D
@export var hitbox_duration_time: float = 0.3

@onready var duration_timer := Timer.new()
var enemies_inside = null

func _ready() -> void:
	_set_duration_timer_propeties()
	state.connect('enter_state_signal', on_enter_state_signal)
	

func _physics_process(_delta: float) -> void:
	if duration_timer.time_left as bool:
		attack()
		do_damage()
	pass


func attack() -> void:
	if is_monitoring():
		if has_overlapping_bodies():
			enemies_inside = get_overlapping_bodies()
			set_monitoring(false)
		else:
			enemies_inside = null


func do_damage() -> void:
	if enemies_inside != null:
		for enemy in enemies_inside:
			if enemy.has_method('take_damage'):
				enemy.take_damage(parent.stats.damage)
		enemies_inside = null


func on_timer_timeout() -> void:
	set_monitoring(false)

## ejecuta este codigo al escuchar state_signal
func on_enter_state_signal() -> void:
	duration_timer.start(hitbox_duration_time)
	set_monitoring(true)


func _set_duration_timer_propeties() -> void:
	duration_timer.one_shot = true
	duration_timer.autostart = false
	add_child(duration_timer)
	duration_timer.connect('timeout', on_timer_timeout)