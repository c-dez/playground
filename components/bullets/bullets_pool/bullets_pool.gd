extends Node3D
class_name BulletsPool


@onready var bullet: PackedScene = preload('res://components/bullets/bullet.tscn')
@onready var enemies_node: Node3D = get_tree().get_first_node_in_group('enemies_node')
var enemies_count: int
var bullets_per_enemy: int = 10

func _ready() -> void:
    for i in enemies_node.get_children():
        enemies_count += 1

    for i in range(enemies_count * bullets_per_enemy):
        var b: Bullet = bullet.instantiate()
        b.name = 'Bullet_%s' % (i)
        b.starting_pos = global_position
        add_child(b)
        
