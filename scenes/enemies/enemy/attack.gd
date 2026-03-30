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

    var number_of_bullets := 1
    for i in range(number_of_bullets):
        var b: Bullet = bullet.instantiate()
        bullets_pool_node.add_child(b)
        bullets_pool.append(b)
        b.damage = owner.attack_damage
        b.name = 'Bullet_%s' % (++1)
        b.starting_pos = Vector3(owner.global_position.x, 10, owner.global_position.z)

func enter() -> void:
    timer.start(1)
    print(self )
    # seleccionar ataque?
    shoot()



func physics_process(_delta: float) -> void:
    owner.velocity = Vector3.ZERO



func exit() -> void:
    # regresar a idle?
    pass



func on_timer_timeout() -> void:
    emit_signal('change_state_to', self , 'idle')

func _select_attack() -> int:
    var attack: int = 0

    return attack



func shoot() -> void:
    for i in bullets_pool:
        i.global_position = owner.global_position
        i.set_active(true)
        var player_pos = owner.player.global_position
        i.look_at(player_pos)
        var direction = -i.transform.basis.z
        var fuerza = 10

        i.linear_velocity = direction.normalized() * fuerza
    # emit_signal('change_state_to', self, 'idle')
