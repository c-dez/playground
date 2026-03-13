extends Area3D
class_name Hurtbox

## Nombre de el metodo a usar cuando area_entered
var method_callable_string:String = ''


func _ready() -> void:
    connect('area_entered', _on_area_entered)
    # if method_callable_string.is_empty():
    #     printerr('method_callable_string empty: ', owner.name,' -> ', self)


func _on_area_entered(hitbox: Hitbox) -> void:
    if hitbox == null:
        return
    if owner.has_method(method_callable_string):
        print(owner)
    pass