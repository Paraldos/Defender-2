extends Node2D

var pause = preload('res://Menus/PauseMenu/pause_menu.tscn')

func _process(_delta):
	if Input.is_action_just_pressed('ui_pause'):
		if Utils.modals.is_empty():
			if weakref(Utils.player.node).get_ref() && Utils.player.node.controlls_enabled:
				_open_pause_menu()

func _open_pause_menu():
	var new = pause.instantiate()
	get_tree().current_scene.add_child(new)
