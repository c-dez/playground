extends Hitbox


func _ready() -> void:
    super._ready()
    top_level = true


func on_state_signal() -> void:
    super.on_state_signal()
    global_position = parent.global_position
