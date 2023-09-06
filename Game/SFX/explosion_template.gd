extends Node2D

var rng = RandomNumberGenerator.new()
@export var screen_shake = 0.0
@export var audio_variation = 0.1
@onready var audio_stream_player = $AudioStreamPlayer

###############################################################################
func _ready():
	rng.randomize()
	rotation = rng.randf_range(-5, 5)
	_play_sfx()
	_add_screenshake()

func _add_screenshake():
	if screen_shake > 0:
		Utils.screen_shake.emit(screen_shake, 0.2)

func _play_sfx():
	audio_stream_player.pitch_scale = rng.randf_range(1.0 -audio_variation, 1.0 + audio_variation)
	audio_stream_player.play()
