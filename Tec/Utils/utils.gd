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

var viewport_width = 480
var viewport_height = 270
var player = {
	max_hp = 50,
	hp = 50,
	max_ep = 50,
	ep = 50,
	dmg = 5,
	node = null,
	position = Vector2.ZERO,
	credits = 500_000,
	gun = 1,
	magnet = 1,
	bomb = 0,
	laser = 0,
	shield = 0
}
var player_backup
var powerup = false
var time_to_next_powerup = 30
var stage = {
	enemies_total = 0,
	enemies_killed = 0,
}

###############################################################################
func _ready():
	_start_powerup_timer()

#########################
func _start_powerup_timer():
	powerup = false
	await get_tree().create_timer(time_to_next_powerup).timeout
	powerup = true
