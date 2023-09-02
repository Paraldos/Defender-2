extends Button

@export var btnText = ''
@export var attribute = ''
@export var cost_multiplier = 1_000
@export var max = 1
@export var description_text = ''

###############################################################################
func _ready():
	Utils.update_shop_text.connect(_update_btn_text)
	_update_btn_text(_get_cost(), description_text)

###############################################################################
func _get_cost():
	return (Utils.player[attribute] + 1) * cost_multiplier

func _update_btn_text(_cost, _text):
	if btnText:
		text = "%s: %s" % [btnText, Utils.player[attribute]]
	else:
		text = 'Shop Button'

###############################################################################
func _check_if_upgrad_is_valid():
	if attribute:
		var max_value = Utils.player[attribute] < max
		var cost = Utils.player.credits >= _get_cost()
		return max_value && cost
	else:
		return false

###############################################################################
func _upgrad_attribute():
	Utils.player.credits -= _get_cost()
	Utils.player[attribute] += 1

###############################################################################
func _on_pressed():
	if _check_if_upgrad_is_valid():
		_upgrad_attribute()
		Utils.update_shop_text.emit(_get_cost(), description_text)
	else:
		pass

func _on_focus_entered():
	if attribute:
		Utils.update_shop_text.emit(_get_cost(), description_text)
	else:
		Utils.update_shop_text.emit('', '')
