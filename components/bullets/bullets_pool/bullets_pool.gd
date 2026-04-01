extends Node3D
class_name BulletsPool

## Nodo usado para almacenar todas las balas que los enemigos usan, aqui se almacenan(is_active == false) y cuando un enemigo las usa (is_active == true) cambian sus propiedades, hasta que se dejan de usar


@onready var bullet: PackedScene = preload('res://components/bullets/bullet.tscn')
@onready var enemies_node: Node3D = get_tree().get_first_node_in_group('enemies_node')
# var enemies_count: int
# var bullets_per_enemy: int = 10

# Para que un enemigo pueda disparar 3 balas consecutivas se necesitan 10 balas en el pool, 
# con 100 balas podria tener 10 enemigos disparando sin problemas ala vez
var number_of_bullets: int = 100

func _ready() -> void:
    #no necesito tantas balas, solo se activan un puinado de enemigos a la vez, con este numero de balas seria como si todos los enemigos estuvieran atacando ala vez
    # for i in enemies_node.get_children():
        # enemies_count += 1

    # for i in range(enemies_count * bullets_per_enemy):
    for i in range(number_of_bullets):
        var b: Bullet = bullet.instantiate()
        b.name = 'Bullet_%s' % (i)
        b.starting_pos = global_position
        add_child(b)
