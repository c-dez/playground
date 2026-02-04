extends Enemy
class_name KatanaChan
# este enum podria representarse mejor con el arma que esta usando?
# enum {
#     REVOLVER,
#     SWORD,
#     BOTH
# }
# ## enum {REVOLVER,AGRESSIVE}
# var current_weapon:int= REVOLVER


func _ready():
	super._ready()
	print(attack_machine.states)

@onready var label:RichTextLabel = get_node('RichTextLabel')
func _process(_delta: float) -> void:
	var state = attack_machine.current_state.name
	label.text = 'KATANACHAN:\nstate: %s \n' %[state]
