extends Button

@onready var audio_click = $AudioClick
@onready var audio_accept = $AudioAccept
@onready var audio_denied = $AudioDenied
var sound_enabled = false

func _ready():
	await get_tree().create_timer(0.1).timeout
	sound_enabled = true

func _on_focus_entered_base():
	if sound_enabled:
		audio_click.play()
