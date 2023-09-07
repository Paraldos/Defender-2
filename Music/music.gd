extends Node

@onready var audio_stream_player = $AudioStreamPlayer
var music = [
	preload("res://Assets/audio/music/Nihilore - Broken Parts - 04 The Water and the Well.mp3"),
	preload("res://Assets/audio/music/Nihilore - Broken Parts - 06 Bush Week.mp3"),
	preload("res://Assets/audio/music/Nihilore - Broken Parts - 07 Dissent.mp3"),
	preload("res://Assets/audio/music/Nihilore - Broken Parts - 10 Walks of Life.mp3"),
	preload("res://Assets/audio/music/Nihilore - Consequences EP - 03 Solipsism.mp3"),
	preload("res://Assets/audio/music/Nihilore - The Hermeneutic Circle - 02 Whispers Invoke Paranoia.mp3"),
	preload("res://Assets/audio/music/Nihilore - Truth and Justification - 05 In the Belly of the Whale.mp3")
]

##############################################################################
func _ready():
	_start_music()

##############################################################################
func _on_audio_stream_player_finished():
	_start_music()

################################# HELPER
func _start_music():
	_change_song()
	audio_stream_player.play()

func _change_song():
	var current_list = music.duplicate()
	current_list.erase(audio_stream_player.stream)
	var song = current_list.pick_random()
	audio_stream_player.stream = song
