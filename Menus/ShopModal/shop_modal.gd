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
var gun_cost = (Utils.player.gun + 1) * 3_000
var magnet_cost = (Utils.player.magnet + 1) * 1_000

###############################################################################
func _ready():
	_update_text()
	btn_next.grab_focus()

###############################################################################
func _update_text():
	label_credits.text = 'Credits: %s' % Utils.player.credits
	btn_gun.text = 'Gun: %s' % Utils.player.gun
	btn_magnet.text = 'Magnet: %s' % Utils.player.magnet
	btn_bomb.text = 'Mega Bomb: %s' % Utils.player.mega_bombe
	btn_laser.text = 'Mega Laser: %s' % Utils.player.mega_laser
	btn_shield.text = 'Mega Shield: %s' % Utils.player.mega_shield

###############################################################################
func _cost_label(cost):
	label_cost.text = 'Cost: %s' % cost

###############################################################################
func _on_btn_next_pressed():
	animation_player.play("move_out")
	await get_tree().create_timer(1).timeout
	SceneTransition._change_scene("res://Game/World/world.tscn")

###############################################################################
func _on_btn_gun_pressed():
	if Utils.player.gun < 5 and Utils.player.credits >= gun_cost:
		Utils.player.credits -= gun_cost
		Utils.player.gun += 1
		_update_text()

func _on_btn_gun_focus_entered():
	_cost_label(gun_cost)

###############################################################################
func _on_btn_magnet_pressed():
	if Utils.player.magnet < 5 and Utils.player.credits >= magnet_cost:
		Utils.player.credits -= magnet_cost
		Utils.player.magnet += 1
		_update_text()

func _on_btn_magnet_focus_entered():
	_cost_label(magnet_cost)
