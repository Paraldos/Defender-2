extends Node

signal stop_wave
signal change_hp
signal screen_shake(strength : float, duration : float)

var viewport_width = 480
var viewport_height = 270

var player = {
	max_hp = 50,
	hp = 30,
	dmg = 5,
	node = null,
	position = Vector2.ZERO,
	credits = 0,
}
