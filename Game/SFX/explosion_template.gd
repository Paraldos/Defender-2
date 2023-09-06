extends Node2D

var rng = RandomNumberGenerator.new()
@export var screen_shake = 0.0
@onready var audio_stream_player = $AudioStreamPlayer

###############################################################################
func _ready():
	audio_stream_player.pitch_scale = rng.randf_range(0.9, 1.1)
	audio_stream_player.play()
	rng.randomize()
	rotation = rng.randf_range(-5, 5)
	if screen_shake > 0:
		Utils.screen_shake.emit(screen_shake, 0.2)
