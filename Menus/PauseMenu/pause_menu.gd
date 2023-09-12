extends "res://Menus/modal_template.gd"

@onready var btn_return = %BtnReturn
@onready var btn_options = %BtnOptions
@onready var label_gun = %LabelGun
@onready var label_magnet = %LabelMagnet
@onready var label_bomb = %LabelBomb
@onready var label_laser = %LabelLaser
@onready var label_shield = %LabelShield
var options_modal = preload("res://Menus/Options/options_modal.tscn")
var return_focus = btn_return

##############################################################################
func _ready():
	super._ready()
	get_tree().paused = true
	btn_return.grab_focus()
	_update_txt()
	Utils.back_to_start.connect(_on_back_to_start)

func _update_txt():
	label_gun.text = '%s: %s' % ['Gun', Utils.player.gun]
	label_magnet.text = '%s: %s' % ['Magnet', Utils.player.magnet]
	label_bomb.text = '%s: %s' % ['Mega Bomb', Utils.player.bomb]
	label_laser.text = '%s: %s' % ['Mega Laser', Utils.player.laser]
	label_shield.text = '%s: %s' % ['Mega Shield', Utils.player.shield]

##############################################################################
func _on_back_to_start(_back_to_start):
	_move_in()
	return_focus.grab_focus()

##############################################################################
func _physics_process(_delta):
	if Input.is_action_just_pressed('ui_pause') && !animation_player.is_playing():
		animation_player.play("move_out")
		await _panel_wait()
		get_tree().paused = false

##############################################################################
func _on_btn_return_pressed():
	animation_player.play("move_out")
	await _panel_wait()
	get_tree().paused = false

##############################################################################
func _on_btn_options_pressed():
	_move_panel_to_side()
	return_focus = btn_options
	var new = options_modal.instantiate()
	get_tree().current_scene.add_child(new)

##############################################################################
func _on_btn_quit_pressed():
	SceneTransition._change_scene("res://Menus/StartMenu/start_menu.tscn")

