extends RigidBody3D
class_name Bullet

@onready var hitbox: Hitbox = get_node('Hitbox')
var damage: int = 0
var is_active: bool = false
var starting_pos: Vector3

func _ready() -> void:
    top_level = true
    hitbox.connect('area_entered', on_area_entered)
    set_active(false)
    global_position = starting_pos
    visible = true


func on_area_entered(area: Hurtbox) -> void:
    if area.owner.has_method('take_damage'):
        area.owner.take_damage(damage)
        set_active(false)


func set_active(value: bool = false) -> void:
    # visible = value
    # hitbox.set_monitoring(value)
    # hitbox.set_monitorable(value)
    is_active = value
    hitbox.call_deferred('set_monitorable', value)
    hitbox.call_deferred('set_monitoring', value)

    if value == false:
        global_position = starting_pos
        linear_velocity = Vector3.ZERO


