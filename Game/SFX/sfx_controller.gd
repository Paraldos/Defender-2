extends Node

var explosion_01 = preload("res://Game/SFX/explosion_01.tscn")
var explosion_02 = preload("res://Game/SFX/explosion_02.tscn")
var explosion_03 = preload("res://Game/SFX/explosion_03.tscn")
var explosion_04 = preload("res://Game/SFX/explosion_04.tscn")
var explosion_05 = preload("res://Game/SFX/explosion_05.tscn")

func _spawn_explosion_01(pos):
	call_deferred('_spawn_sfx', pos, explosion_01)

func _spawn_explosion_02(pos):
	call_deferred('_spawn_sfx', pos, explosion_02)

func _spawn_explosion_03(pos):
	call_deferred('_spawn_sfx', pos, explosion_03)

func _spawn_explosion_04(pos):
	call_deferred('_spawn_sfx', pos, explosion_04)

func _spawn_explosion_05(pos):
	call_deferred('_spawn_sfx', pos, explosion_05)

func _spawn_sfx(pos, effect):
	var new = effect.instantiate()
	new.global_position = pos
	get_tree().current_scene.add_child(new)
