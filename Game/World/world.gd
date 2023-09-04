extends Node2D

var pause = preload('res://Menus/PauseMenu/pause_menu.tscn')
var pause_button_enabled = false

func _ready():
	Utils.enable_pause_button.connect(_on_enable_pause_button)

func _process(delta):
	if Input.is_action_just_pressed('ui_pause') && pause_button_enabled && Utils.modals.is_empty():
		_open_pause_menu()

func _on_enable_pause_button(new_state):
	pause_button_enabled = new_state

func _open_pause_menu():
	var new = pause.instantiate()
	get_tree().current_scene.add_child(new)
