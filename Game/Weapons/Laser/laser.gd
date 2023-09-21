extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer

##############################################################################
func _ready():
	visible = false

##############################################################################
func _attack():
	audio_stream_player.play()
