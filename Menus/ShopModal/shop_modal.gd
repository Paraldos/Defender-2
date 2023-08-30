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

###############################################################################
func _ready():
	label_credits.text = 'Credits: %s' % Utils.player.credits
	btn_gun.text = 'Gun: %s' % Utils.player.gun
	btn_magnet.text = 'Magnet: %s' % Utils.player.magnet
	btn_bomb.text = 'Mega Bomb: %s' % Utils.player.mega_bombe
	btn_laser.text = 'Mega Laser: %s' % Utils.player.mega_laser
	btn_shield.text = 'Mega Shield: %s' % Utils.player.mega_shield
	btn_next.grab_focus()

###############################################################################
func _on_btn_next_pressed():
	animation_player.play("move_out")
	await get_tree().create_timer(1).timeout
	SceneTransition._change_scene("res://Game/World/world.tscn")

###############################################################################
