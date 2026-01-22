extends MeshInstance3D
class_name HealthPack

var health:int = 20
@onready var area:Area3D = get_node('Area3D')

func _ready() -> void:
    area.connect('body_entered', on_player_entered)


func on_player_entered(body:Node3D)-> void:
    if body is PlayerBody:
        if body.has_method('take_health'):
            body.take_health(health)
            queue_free()
    pass
