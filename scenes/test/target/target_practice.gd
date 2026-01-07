extends CharacterBody3D


@onready var timer:Timer = Timer.new()
var hide_time:float = 3.0
@onready var collision:CollisionShape3D = get_node('CollisionShape3D')

func _ready() -> void:
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.connect('timeout', on_timer_timeout)

# func _process(_delta: float) -> void:
# 	visible = not timer.time_left as bool
# 	if not visible:
# 		collision.disabled = true
	


func hide_on_hit():
	timer.start(hide_time)
	visible = false
	collision.visible = false

func on_timer_timeout()->void:
	visible = true
