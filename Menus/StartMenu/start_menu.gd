extends Node2D

@onready var buttons = %Buttons

func _ready():
	await get_tree().create_timer(0.1).timeout
	buttons.get_child(0).grab_focus()

func _on_btn_new_game_pressed():
	SceneTransition._change_scene("res://Game/World/world.tscn")
