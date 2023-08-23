extends Node

signal stop_wave
signal change_hp
signal change_ep
signal screen_shake(strength : float, duration : float)

var viewport_width = 480
var viewport_height = 270
var player = {
	max_hp = 50,
	hp = 25,
	max_ep = 50,
	ep = 25,
	dmg = 5,
	node = null,
	position = Vector2.ZERO,
	credits = 0,
}
var powerup = false
var time_to_next_powerup = 30

###############################################################################
func _ready():
	_start_powerup_timer()

#########################
func _start_powerup_timer():
	powerup = false
	await get_tree().create_timer(time_to_next_powerup).timeout
	powerup = true
