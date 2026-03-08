extends Area3D

var enemies_inside_attack_area_list
@export var ground_pound: State
@onready var parent: CharacterBody3D = get_parent()
@onready var timer := Timer.new()
var area_damage_time: float = 0.3


func _ready() -> void:
	ground_pound.connect('ground_pound_area_signal', on_ground_pound_signal)
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	top_level = true


func _physics_process(_delta: float) -> void:
	if timer.time_left as bool:
		attack()
		do_damage()
		
	else:
		set_monitoring(false)


func attack() -> void:
	if is_monitoring():
		if has_overlapping_bodies():
			enemies_inside_attack_area_list = get_overlapping_bodies()
			set_monitoring(false)
		else:
			enemies_inside_attack_area_list = null


func do_damage() -> void:
	if enemies_inside_attack_area_list != null:
		for item in enemies_inside_attack_area_list:
			if item.has_method('take_damage'):
				item.take_damage(parent.stats.damage)
		enemies_inside_attack_area_list = null


func on_ground_pound_signal() -> void:
	global_position = parent.global_position
	timer.start(area_damage_time)
	set_monitoring(true)
	pass