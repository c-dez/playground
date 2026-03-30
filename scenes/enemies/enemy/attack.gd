extends State
class_name EnemyAttack


@onready var timer := Timer.new()
@onready var bullet: PackedScene = preload('res://components/bullets/bullet.tscn')
@onready var bullets_pool_node: Node3D = owner.get_node('BulletsPool')

var bullets_pool: Array = []


func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.connect('timeout', on_timer_timeout)
	
	var number_of_bullets := 3
	for i in range(number_of_bullets):
		var b: Bullet = bullet.instantiate()
		bullets_pool_node.add_child(b)
		bullets_pool.append(b)
		b.damage = owner.attack_damage


func enter() -> void:
	# timer.start(1)
	print(self )

	# seleccionar ataque?


func physics_process(_delta: float) -> void:
	owner.velocity = Vector3.ZERO
	if Input.is_action_just_pressed('r_key'):
		bullets_pool[0].set_active(not bullets_pool[0].is_active)
	# ejecutar ataque


func exit() -> void:
	# regresar a idle?
	pass


func on_timer_timeout() -> void:
	emit_signal('change_state_to', self , 'idle')

func _select_attack() -> int:
	var attack: int = 0

	return attack
