extends Area3D
class_name DamageArea

@export var damage: int = 5
@onready var collision: CollisionShape3D = get_node('CollisionShape3D')
@onready var decal: Decal = get_node('Decal')
@onready var player: PlayerBody = get_tree().get_first_node_in_group('player')
@onready var damage_timer: Timer = Timer.new()
var damage_timer_time: float = 1
@onready var duration_timer: Timer = Timer.new()
var duration_timer_time: float = 5.0


var area_size: Vector3

func _ready() -> void:
    top_level = true
    # damage_timer
    add_child(damage_timer)
    damage_timer.one_shot = false
    damage_timer.autostart = false
    damage_timer.connect('timeout', on_damage_timer_timeout)
    # duration_timer
    add_child(duration_timer)
    duration_timer.autostart = true
    duration_timer.one_shot = true
    duration_timer.start(duration_timer_time)
    duration_timer.connect('timeout', on_duration_timer_timeout)
    
    connect('body_entered', on_player_entered)
    connect('body_exited', on_player_exited)

    position = player.global_position
    position.y = player.global_position.y - 1.5


func _physics_process(_delta: float) -> void:
    pass


func on_player_entered(body: Node3D) -> void:
    if body is PlayerBody:
        damage_timer.start(damage_timer_time)
    pass

func on_player_exited(body: Node3D) -> void:
    if body is PlayerBody:
        damage_timer.stop()

func on_damage_timer_timeout() -> void:
    player.take_damage(damage)


func on_duration_timer_timeout() -> void:
    call_deferred('queue_free')