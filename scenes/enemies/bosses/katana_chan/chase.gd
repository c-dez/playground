extends Chase


var dice: int
var trow_dice_time: float = 3
const _trow_dice_time: float = 3
var selected_attack: String

var attacks: Dictionary = {
	'light': 'light',
	'heavy': 'heavy',
	'combo': 'combo',
	'special': 'special'
}
var distance_to_player
func enter() -> void:
	super.enter()
	trow_dice()
	selected_attack = select_attack()


func process(_delta: float) -> void:
	# super.process(_delta)
	distance_to_player = parent.global_position.distance_to(player.global_position)
	_change_state_to()
	pass


func physics_process(_delta: float) -> void:
	if dice <= 6:
		chase(_delta, parent.stats.walk_speed)
		trow_dice_to_change_chase_speed(_delta)
	else:
		chase(_delta, parent.stats.dash_speed)
		pass
	

func trow_dice_to_change_chase_speed(_delta: float) -> void:
	trow_dice_time -= _delta
	if trow_dice_time < 0:
		trow_dice()
		trow_dice_time = _trow_dice_time
	pass


func trow_dice() -> void:
	dice = randi() % 10


func select_attack() -> String:
	var rand_num := randi() % 4
	var result: String
	match rand_num:
		0:
			result = attacks['light']
		1:
			result = attacks['heavy']
		2:
			result = attacks['combo']
		3:
			result = attacks['special']
			
		_:
			printerr('select attack overflow: ', rand_num)

	return result


func _change_state_to() -> void:
	match selected_attack:
		'light':
			if distance_to_player < parent.stats.light_range:
				emit_signal('change_state_to', self, 'light')
		'heavy':
			if distance_to_player < parent.stats.heavy_range:
				emit_signal('change_state_to', self, 'heavy')
		'combo':
			if distance_to_player < parent.stats.combo_range:
				emit_signal('change_state_to', self, 'combo')
		'special':
			if distance_to_player < parent.stats.special_range:
				emit_signal('change_state_to', self, 'special')
