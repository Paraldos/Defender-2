extends Node2D

var mega_bomb = preload("res://Game/Player/mega_bomb.tscn")
@export var activation_cost = 12

func _ready():
	activation_cost -= (Utils.player.bomb * 2)

func _physics_process(_delta):
	if get_parent().invulnerable: return
	if !get_parent().controlls_enabled: return
	if Utils.player.bomb <= 0: return
	if Input.is_action_just_pressed('ui_mega_bomb'):
		if Utils.player.ep >= activation_cost:
			Utils.player.ep -= activation_cost
			Utils.change_ep.emit()
			_spawn_mega_bomb()

func _spawn_mega_bomb():
	var new = mega_bomb.instantiate()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)
