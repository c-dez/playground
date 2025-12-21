extends ProgressBar


# @export var shooting_manager: ShootingManager
@onready var shooting_manager: ShootingManager = get_parent().get_parent().get_node('ShootingManager')
var reload_time: float = 0.0
var elapsed_time: float = 0.0
var running: bool = false
signal active_reload_signal()

@onready var active_reload_range = get_parent().get_parent().active_reload_range


func _ready() -> void:
	shooting_manager.connect('start_reloading', on_start_reloading)
	visible = false
	

func _physics_process(delta: float) -> void:
	visible = running
	if running:
		start(delta)

		
func on_start_reloading(reloading_time: float) -> void:
	running = true
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
	running = false

	
## si player presiona reload dentro de el margen el reload termina antes
func active_reload() -> void:
	if Input.is_action_just_pressed('r_key') and value > active_reload_range.x and value < active_reload_range.y:
		active_reload_signal.emit()
		finish()