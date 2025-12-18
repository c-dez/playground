extends Node3D
class_name ShootingManager

var target_enemy: CharacterBody3D
var target_collision_point: Vector3

@export var camera: Camera3D
@onready var ray_cast: RayCast3D = get_node("ShootingRayCast")


##
# revolver
var bullets: int = 6
var max_bullets = 6

var reload_time = 0.5
var revolver_current_state = revolver_states.fire
enum revolver_states {
	fire,
	reloading
}
var timer = Timer.new()

var label: Label


func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	label = Label.new()
	add_child(label)

	pass

func _process(_delta: float) -> void:
	_set_tranform()
	shoot()
	if Input.is_action_just_pressed('r_key'):
		reload()
	var label_text = str(bullets, '\n', timer.time_left, '\n', revolver_current_state)
	label.text = label_text


func shoot() -> void:
	if PlayerInput.left_mb():
		if bullets <= 0 and revolver_current_state == revolver_states.fire:
			reload()
			
			return

		if revolver_current_state == revolver_states.fire:
			bullets -= 1

			if ray_cast.is_colliding():
				target_collision_point = ray_cast.get_collision_point()
				if ray_cast.get_collider() is CharacterBody3D:
					target_enemy = ray_cast.get_collider()
					print(target_enemy)

			else:
				target_collision_point = Vector3.ZERO

	
## usa el tranforn de camera  como el propio
func _set_tranform() -> void:
	position = camera.position
	rotation = camera.rotation


func reload() -> void:
	
	if bullets == 6:
		return
	else:
		timer.start((max_bullets - bullets) * reload_time)

		if timer.time_left:
			revolver_current_state = revolver_states.reloading
			print('time to reload')

		timer.connect('timeout', func():
			revolver_current_state = revolver_states.fire
			bullets = max_bullets
			)


		# reload 
			# tiempo de reload * bullet faltante

	# if bullets == 0 and shoot()
		#reload
	pass
