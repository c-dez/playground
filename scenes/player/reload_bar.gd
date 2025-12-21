extends ProgressBar


@export var shooting_manager: ShootingManager
var reload_time: float = 0.0
var elapsed_time: float = 0.0
var running: bool = false


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

	if elapsed_time >= reload_time:
		finish()


func finish() -> void:
	running = false
