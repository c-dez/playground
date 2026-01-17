extends Node3D
@onready var mesh:MeshInstance3D = get_parent().get_node('MeshInstance3D')
@onready var ray:RayCast3D = get_node('RayCast3D')



func _process(_delta: float) -> void:
    rotation = mesh.rotation

    pass
