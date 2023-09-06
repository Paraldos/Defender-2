extends Node2D

@onready var buttons = %Buttons
var options_modal = preload("res://Menus/Options/options_modal.tscn")
var credits_modal = preload('res://Menus/CreditsModal/credits_modal.tscn')

func _ready():
	Utils.back_to_start.connect(_on_back_to_start)
	await get_tree().create_timer(0.1).timeout
	buttons.get_child(0).grab_focus()

func _on_back_to_start(target_node):
	match target_node:
		'options':
			buttons.get_child(1).grab_focus()
		'credits':
			buttons.get_child(2).grab_focus()

func _on_btn_new_game_pressed():
	Utils._reset_player()
	SceneTransition._change_scene("res://Game/World/world.tscn")

func _on_btn_options_pressed():
	var new = options_modal.instantiate()
	get_tree().current_scene.add_child(new)

func _on_btn_credits_pressed():
	var new = credits_modal.instantiate()
	get_tree().current_scene.add_child(new)

func _on_btn_quit_pressed():
	get_tree().quit()

