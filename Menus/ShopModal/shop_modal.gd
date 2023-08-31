extends "res://Menus/modal_template.gd"

@onready var label_credits = %LabelCredits
@onready var btn_next = %BtnNext
###
@onready var btn_gun = %BtnGun
@onready var btn_magnet = %BtnMagnet
@onready var btn_bomb = %BtnBomb
@onready var btn_laser = %BtnLaser
@onready var btn_shield = %BtnShield
###
@onready var label_cost = %LabelCost
@onready var label_description = %LabelDescription
###
var reset = {
	text = 'Revoke all purchuses you made / Restore your values and credits to what you started with.'
}
var gun = {
	UtilsName = 'gun',
	cost = (Utils.player.gun + 1) * 3_000,
	max = 5
}
var magnet = {
	UtilsName = 'magnet',
	cost = (Utils.player.magnet + 1) * 1_500,
	max = 5
}
var bomb = {
	UtilsName = 'bomb',
	cost = (Utils.player.bomb + 1) * 2_000,
	max = 3
}
var laser = {
	UtilsName = 'laser',
	cost = (Utils.player.laser + 1) * 2_000,
	max = 3
}
var shield = {
	UtilsName = 'shield',
	cost = (Utils.player.shield + 1) * 2_000,
	max = 3
}

###############################################################################
func _ready():
	_btn_text()
	Utils.player_backup = Utils.player.duplicate()
	btn_next.grab_focus()

###############################################################################
func _btn_text():
	label_credits.text = 'Credits: %s' % Utils.player.credits
	btn_gun.text = 'Gun: %s' % Utils.player.gun
	btn_magnet.text = 'Magnet: %s' % Utils.player.magnet
	btn_bomb.text = 'Mega Bomb: %s' % Utils.player.bomb
	btn_laser.text = 'Mega Laser: %s' % Utils.player.laser
	btn_shield.text = 'Mega Shield: %s' % Utils.player.shield

func _cost_label(cost):
	label_cost.visible = true
	label_cost.text = 'Cost: %s' % cost

func _description_label(txt):
	label_description.visible = true
	label_description.text = txt

###############################################################################
func _check_if_upgrad_is_valid(attribute):
	var max_value = Utils.player[attribute.UtilsName] < attribute.max
	var cost = Utils.player.credits >= attribute.cost
	return max_value && cost

###############################################################################
func _upgrad_attribute(attribute):
	Utils.player.credits -= gun.cost
	Utils.player[attribute.UtilsName] += 1
	_btn_text()

################################################################ NEXT
func _on_btn_next_pressed():
	animation_player.play("move_out")
	await get_tree().create_timer(1).timeout
	SceneTransition._change_scene("res://Game/World/world.tscn")

func _on_btn_next_focus_entered():
	label_cost.visible = false
	label_description.visible = false

################################################################ RESET
func _on_btn_reset_pressed():
	Utils.player = Utils.player_backup.duplicate()
	_btn_text()

func _on_btn_reset_focus_entered():
	label_cost.visible = false
	_description_label(reset.text)

################################################################ GUN
func _on_btn_gun_pressed():
	if _check_if_upgrad_is_valid(gun):
		_upgrad_attribute(gun)
	else:
		pass

func _on_btn_gun_focus_entered():
	_cost_label(gun.cost)
	_description_label('')

################################################################ MAGNET
func _on_btn_magnet_pressed():
	if _check_if_upgrad_is_valid(magnet):
		_upgrad_attribute(magnet)
	else:
		pass

func _on_btn_magnet_focus_entered():
	_cost_label(magnet.cost)
	_description_label('')

################################################################ BOMB
func _on_btn_bomb_pressed():
	pass # Replace with function body.

func _on_btn_bomb_focus_entered():
	_cost_label(bomb.cost)
	_description_label('')

################################################################ LASER
func _on_btn_laser_pressed():
	pass # Replace with function body.

func _on_btn_laser_focus_entered():
	_cost_label(laser.cost)
	_description_label('')

################################################################ SHIELD
func _on_btn_shield_pressed():
	pass # Replace with function body.

func _on_btn_shield_focus_entered():
	_cost_label(shield.cost)
	_description_label('')



