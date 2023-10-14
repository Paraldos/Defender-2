extends Node

signal stop_wave
signal change_hp
signal change_ep
signal screen_shake(strength : float, duration : float)
signal scene_transition_done
signal change_background_speed(new_speed : Vector2)
signal boss_dying
signal boss_dead
signal stop_modal_background
signal update_shop_text(cost : int, text : String)
signal back_to_start(target_node)
signal spawn_treasure(amount, position)
signal player_death

var viewport_width = 480
var viewport_height = 270
@export var player_start = {
	max_hp = 50,
	hp = 50,
	max_ep = 40,
	ep = 40,
	dmg = 3,
	node = null,
	position = Vector2.ZERO,
	credits = 0,
	gun = 1,
	magnet = 1,
	bomb = 1,
	laser = 1,
	shield = 0,
}
var player = {}
var player_backup
var modals = []
############################ STAGE INFO
var stage_empty = {
	enemies_spawned = 0,
	enemies_killed = 0,
	bosses_spawned = 0,
	bosses_killed = 0,
	completed = 0
}
var stage = stage_empty.duplicate()
var total = stage_empty.duplicate()

func _reset_player():
	player = player_start.duplicate()
	stage = stage_empty.duplicate()
	total = stage_empty.duplicate()

func _next_satage():
	stage = stage_empty.duplicate()
	total.completed += 1


