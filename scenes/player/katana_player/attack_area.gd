extends Hitbox

func _ready() -> void:
	super._ready()
	top_level = true

func _process(_delta):
	rotation.y = parent.mesh.rotation.y
	global_position = parent.global_position
	pass

