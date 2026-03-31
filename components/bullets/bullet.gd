extends RigidBody3D
class_name Bullet


# TODO si el padre muere y se destruye, las balas deben persistir hasta que despwneen, cuando pase quee)free()

var damage: int ## Se asigna el valor desde la clase Enemy que lo instancea
var is_active: bool = false ## true es cuando fue disparada, hasta que impacta o pasa tiempo 
var starting_pos: Vector3 ## Posicion donde se almacena cuando is_active == false
var despawn_time: float = 5

@onready var hitbox: Hitbox = get_node('Hitbox')
@onready var despawn_timer: Timer = Timer.new()


func _ready() -> void:
    top_level = true
    hitbox.connect('area_entered', on_area_entered)
    set_active(false)
    global_position = starting_pos
    _set_despawn_timer()


func on_area_entered(area: Hurtbox) -> void:
    if area.owner.has_method('take_damage'):
        area.owner.take_damage(damage)
        set_active(false)


func set_active(value: bool = false) -> void:
    visible = value
    is_active = value
    hitbox.call_deferred('set_monitorable', value)
    hitbox.call_deferred('set_monitoring', value)

    if value == false:
        global_position = starting_pos
        linear_velocity = Vector3.ZERO
    else:
        despawn_timer.start(despawn_time)


func _set_despawn_timer() -> void:
    add_child(despawn_timer)
    despawn_timer.one_shot = true
    despawn_timer.autostart = false
    despawn_timer.connect('timeout', set_active.bind(false))
