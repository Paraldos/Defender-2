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
var player_start = {
	max_hp = 50,
	hp = 50,
	max_ep = 40,
	ep = 40,
	dmg = 2,
	node = null,
	position = Vector2.ZERO,
	credits = 0,
	gun = 1,
	magnet = 1,
	bomb = 0,
	laser = 0,
	shield = 0
}
var player = {}
var player_backup
var enemies_killed_total = 0
var enemies_start = {
	total = 0,
	total_killed = 0,
	stage = 0,
	stage_killed = 0,
}
var enemies
var bosses_start = {
	total = 0,
	killed =0
}
var bosses
var modals = []

###############################################################################
func _reset_player():
	player = player_start.duplicate()
	enemies = enemies_start.duplicate()
	bosses = bosses_start.duplicate()

func _reset_satage():
	enemies.stage = 0
	enemies.stage_killed = 0
