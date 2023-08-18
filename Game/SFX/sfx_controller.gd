extends Node

var explosion_01 = preload("res://Game/SFX/explosion_01.tscn")

func _spawn_explosion_01(pos):
	var new = explosion_01.instantiate()
	new.global_position = pos
	get_tree().current_scene.add_child(new)
