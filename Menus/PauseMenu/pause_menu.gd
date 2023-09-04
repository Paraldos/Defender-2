extends "res://Menus/modal_template.gd"

@onready var btn_return = %BtnReturn

func _ready():
	super._ready()
	get_tree().paused = true
	btn_return.grab_focus()

func _physics_process(delta):
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
