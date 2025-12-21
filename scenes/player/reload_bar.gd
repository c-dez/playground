extends ProgressBar


var reload_time: float = 0.0
var elapsed_time: float = 0.0
var is_running: bool = false

@onready var shooting_manager: ShootingManager = get_parent().get_parent().get_node('ShootingManager')
@onready var active_reload_range = get_parent().get_parent().active_reload_range

signal active_reload_signal()


func _ready() -> void:
	shooting_manager.connect('start_reloading', on_start_reloading)
	visible = false
	

func _physics_process(delta: float) -> void:
	visible = is_running
	if is_running:
		start(delta)

		
func on_start_reloading(reloading_time: float) -> void:
	is_running = true
	reload_time = reloading_time
	elapsed_time = 0.0
	

func start(delta: float) -> void:
	elapsed_time += delta
	var percent := (elapsed_time / reload_time) * 100.0
	percent = clamp(percent, 0.0, 100.0)
	value = percent
	active_reload()

	if elapsed_time >= reload_time:
		finish()


func finish() -> void:
	is_running = false

	
## si player presiona reload dentro de el margen el reload termina antes
func active_reload() -> void:
	if (Input.is_action_just_pressed('r_key') or PlayerInput.left_mb()) and value > active_reload_range.x and value < active_reload_range.y:
		active_reload_signal.emit()
		finish()