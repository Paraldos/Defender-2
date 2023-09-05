extends "res://Menus/modal_template.gd"

@onready var btn_return = %BtnReturn
@onready var label_gun = %LabelGun
@onready var label_magnet = %LabelMagnet
@onready var label_bomb = %LabelBomb
@onready var label_laser = %LabelLaser
@onready var label_shield = %LabelShield

func _ready():
	super._ready()
	get_tree().paused = true
	btn_return.grab_focus()
	_update_txt()

func _update_txt():
	label_gun.text = '%s: %s' % ['Gun', Utils.player.gun]
	label_magnet.text = '%s: %s' % ['Magnet', Utils.player.magnet]
	label_bomb.text = '%s: %s' % ['Mega Bomb', Utils.player.bomb]
	label_laser.text = '%s: %s' % ['Mega Laser', Utils.player.laser]
	label_shield.text = '%s: %s' % ['Mega Shield', Utils.player.shield]

func _physics_process(_delta):
	if Input.is_action_just_pressed('ui_pause') && !animation_player.is_playing():
		animation_player.play("move_out")
		await _panel_wait()
		get_tree().paused = false

func _on_btn_return_pressed():
	animation_player.play("move_out")
	await _panel_wait()
	get_tree().paused = false

func _on_btn_quit_pressed():
	SceneTransition._change_scene("res://Menus/StartMenu/start_menu.tscn")
