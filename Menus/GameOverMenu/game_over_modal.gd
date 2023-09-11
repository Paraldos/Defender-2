extends "res://Menus/modal_template.gd"

@onready var btn_again = %BtnAgain

func _ready():
	super._ready()
	btn_again.grab_focus()

func _on_btn_again_pressed():
	Utils._reset_player()
	SceneTransition._change_scene("res://Game/World/world.tscn")

func _on_btn_quit_pressed():
	SceneTransition._change_scene("res://Menus/StartMenu/start_menu.tscn")
