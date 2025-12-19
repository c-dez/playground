extends Control
# croshair

var color := Color.WHITE
var crossHair_size := 10

@onready var timer: Timer

func _ready() -> void:
    var shooting_manager = get_parent().get_parent().get_node('ShootingManager')
    shooting_manager.connect('hit_confirm', _start_hit_confirm_timer)

    timer = Timer.new()
    add_child(timer)
    timer.autostart = false
    timer.one_shot = true


func _draw():
    draw_line(Vector2(-crossHair_size, 0), Vector2(crossHair_size, 0), color, 2)
    draw_line(Vector2(0, -crossHair_size), Vector2(0, crossHair_size), color, 2)


func _process(_delta: float) -> void:
    _hit_confirm()
    pass

## Cambia el crossHair 
func _hit_confirm() -> void:
    if timer.time_left:
        color = Color.RED
        crossHair_size = 25
        queue_redraw()
    else:
        color = Color.WHITE
        crossHair_size = 10
        queue_redraw()

func _start_hit_confirm_timer():
    timer.start(0.1)
