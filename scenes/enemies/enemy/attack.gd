extends State
class_name EnemyAttack


var bullets_pool: Array = []
var number_of_shoots: int = 0## cuantas veces seguidas dispara
const NUMBER_OF_SHOOTS: int = 3

@onready var bullet: PackedScene = preload('res://components/bullets/bullet.tscn')
@onready var bullets_pool_node: Node3D = owner.get_node('BulletsPool')


func _ready() -> void:
    var number_of_bullets := 10
    for i in range(number_of_bullets):
        var b: Bullet = bullet.instantiate()
        bullets_pool_node.add_child(b)
        bullets_pool.append(b)
        b.damage = owner.attack_damage
        b.name = 'Bullet_%s' % (++1)
        b.starting_pos = Vector3(owner.global_position.x, 10, owner.global_position.z)


func enter() -> void:
    # print(self )
    owner.velocity = Vector3.ZERO
    number_of_shoots = NUMBER_OF_SHOOTS
    # todo: podria crear funciones con distintos ataques y seleccionar uno al azar
    shoot_burst()


## dispara tres balas 
func shoot_burst() -> void:
    for _bullet in bullets_pool:
        var player_pos = owner.player.global_position
        if !_bullet.is_active:

            if number_of_shoots <= 0:
                emit_signal('change_state_to', self , 'idle')
                return

            number_of_shoots -= 1

            _bullet.global_position = owner.global_position
            _bullet.look_at(player_pos)
            var direction = -_bullet.transform.basis.z
            _bullet.set_active(true)

            _bullet.linear_velocity = direction.normalized() * owner.bullet_speed
            # todo: puede valer la pena que el await use un Timer node
            await get_tree().create_timer(owner.attack_cooldown).timeout
