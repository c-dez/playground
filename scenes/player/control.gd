extends Control

func _draw():
    var crossHair_size := 10
    var color := Color.WHITE
    draw_line(Vector2(-crossHair_size, 0), Vector2(crossHair_size, 0), color, 2)
    draw_line(Vector2(0, -crossHair_size), Vector2(0, crossHair_size), color, 2)


