extends Attack
class_name FlyingAttack


var damage_area: PackedScene = preload('res://assets/damage_area/damage_area.tscn')
@onready var ray: RayCast3D = get_node('RayCast3D')


func enter() -> void:
    parent.velocity = Vector3.ZERO
    attack_cooldown = parent.stats.attack_cooldown
    ray.global_position = get_ray_global_position()


func shoot(_delta) -> void:
    attack_cooldown -= _delta
    if attack_cooldown < 0:
        ray.global_position = get_ray_global_position()
        if ray.is_colliding():
            if ray.get_collider() is not PlayerBody:
                var d = damage_area.instantiate()
                add_child(d)
                d.global_position = ray.get_collision_point()
                print('shoot')
        attack_cooldown = parent.stats.attack_cooldown


func get_ray_global_position(height: float = 5) -> Vector3:
    return Vector3(player.global_position.x, player.global_position.y + height, player.global_position.z)
