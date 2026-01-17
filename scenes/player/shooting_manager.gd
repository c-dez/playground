extends Node3D
class_name ShootingManager


## Controla el disparar de el jugador, hacer dano, reload...

# DEPRECATED
var target_enemy: CharacterBody3D
var target_collision_point: Vector3

var label: Label
@export var camera: Camera3D

##
# revolver
var bullets: int = 6
var max_bullets: int = 6
var revolver_current_state: int = revolver_states.fire
enum revolver_states {
	fire,
	reloading
}
var reload_time: float = 0.5
var reload_timer: Timer = Timer.new()
##
@onready var player: PlayerBody = get_parent()
@onready var ray_cast: RayCast3D = get_node("ShootingRayCast")
@onready var progress_bar: ProgressBar = player.get_node('HUD').get_node('ProgressBar')

#signals
signal start_reloading(reloading_time: float)
signal hit_confirm()


# func _ready() -> void:
# 	_set_up_reload_timer()
# 	label = Label.new()
# 	add_child(label)
# 	ray_cast.target_position.z = - player.stats.attack_range

# 	progress_bar.connect('active_reload_signal', on_active_reload)


# func _process(_delta: float) -> void:
# 	_set_tranform()
# 	shoot()
# 	if Input.is_action_just_pressed('r_key') and revolver_current_state == revolver_states.fire:
# 		reload_gun()
	
# 	#debug
# 	var label_text := str(bullets, '\n', reload_timer.time_left, '\n', revolver_current_state)
# 	label.text = label_text


func shoot() -> void:
	if PlayerInput.left_mb():
		if bullets <= 0 and revolver_current_state == revolver_states.fire:
			reload_gun()
			return

		if revolver_current_state == revolver_states.fire:
			bullets -= 1

			if ray_cast.is_colliding():
				target_collision_point = ray_cast.get_collision_point()
				if ray_cast.get_collider() is CharacterBody3D:
					# hacer dano a target
					target_enemy = ray_cast.get_collider()

					if target_enemy.has_method('take_damage'):
						target_enemy.stats.take_damage(player.stats.damage)
					else:
						print('asdasdasd')
					#signal
					hit_confirm.emit()

			else:
				target_collision_point = Vector3.ZERO


func reload_gun() -> void:
	if bullets == max_bullets:
		return

	else:
		var reload_max_time = (max_bullets - bullets) * reload_time
		reload_timer.start(reload_max_time)
		start_reloading.emit(reload_max_time)

		if not reload_timer.is_stopped():
			revolver_current_state = revolver_states.reloading
		

## usa el tranforn de camera  como el propio
func _set_tranform() -> void:
	position = camera.position
	rotation = camera.rotation


## propiedades necesarias para reload_timer, que se usa para reload_gun()
func _set_up_reload_timer() -> void:
	add_child(reload_timer)
	reload_timer.one_shot = true
	reload_timer.autostart = false
	reload_timer.connect('timeout', func():
			revolver_current_state = revolver_states.fire
			bullets = max_bullets
	)


func on_active_reload() -> void:
	reload_timer.stop()
	reload_timer.timeout.emit()