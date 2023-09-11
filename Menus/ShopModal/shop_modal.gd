extends "res://Menus/modal_template.gd"

@onready var label_credits = %LabelCredits
@onready var label_cost = %LabelCost
@onready var label_description = %LabelDescription
@onready var btn_next = %BtnNext

var reset_txt = 'Revoke all purchuses you made and restore your values and credits to what you started with.'

###############################################################################
func _ready():
	Utils.player_backup = Utils.player.duplicate()
	Utils.update_shop_text.connect(_on_update_shop_text)
	btn_next.grab_focus()
	_on_update_shop_text(-1, '')

###############################################################################
func _on_update_shop_text(cost, text):
	_credits_label()
	_cost_label(cost)
	_description_label(text)

func _credits_label():
	label_credits.text = 'Credits: %s' % Utils.player.credits

func _cost_label(cost):
	label_cost.visible = cost > 0
	label_cost.text = 'Cost: %s' % cost

func _description_label(txt):
	label_description.visible = txt != ''
	label_description.text = txt

################################################################ NEXT
func _on_btn_next_pressed():
	Utils._reset_satage()
	animation_player.play("move_out")
	await _panel_wait()
	SceneTransition._change_scene("res://Game/World/world.tscn")

func _on_btn_next_focus_entered():
	Utils.update_shop_text.emit(-1, '')

################################################################ RESET
func _on_btn_reset_pressed():
	Utils.player = Utils.player_backup.duplicate()
	Utils.update_shop_text.emit(-1, reset_txt)

func _on_btn_reset_focus_entered():
	label_cost.visible = false
	Utils.update_shop_text.emit(-1, reset_txt)



