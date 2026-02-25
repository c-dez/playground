extends MeshInstance3D


var squash_and_stretch: float = 1.0:
	set(value):
		squash_and_stretch = value
		var negative := 1.0 + (1.0 - squash_and_stretch)
		scale = Vector3(negative, squash_and_stretch, negative)


func do_squash_and_stretch(value: float, duration: float = 0.1) -> void:
	var tween = create_tween()
	tween.tween_property(self, "squash_and_stretch", value, duration)
	tween.tween_property(self, "squash_and_stretch", 1.0, duration * 1.8).set_ease(Tween.EASE_IN_OUT)
