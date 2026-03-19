extends StaticBody3D

var switch_state: bool = false
## true -> can toggle on/off , false -> can only change to true
@export var is_switch_toggleable: bool = true


@onready var hurtbox: Hurtbox = get_node('Hurtbox')

func _ready() -> void:
    hurtbox.connect('area_entered', on_area_entered)


func on_area_entered(hitbox: Hitbox):
    if hitbox == null:
        return
    if hitbox.name == 'GroundPoundHitbox':
        match is_switch_toggleable:
            true:
                switch_state = !switch_state
            false:
                switch_state = true
