extends Hurtbox

# bounce ball hurtbox
func _ready() -> void:
    super._ready()


func toggle_monitoring() -> void:
    var toggle: bool = !is_monitoring()

    call_deferred('set_monitoring', toggle)
    call_deferred('set_monitorable', toggle)