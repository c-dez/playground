extends Node
class_name State

@onready var enemy: BaseEnemy = get_parent().get_parent()
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group('player')

signal transitioned(state: State, new_state_name: String)


func enter() -> void:
	pass

func exit() -> void:
	print('exit()', name)
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

