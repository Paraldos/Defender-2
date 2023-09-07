extends Button

@onready var audio_click = $AudioClick
@onready var audio_accept = $AudioAccept
@onready var audio_denied = $AudioDenied
var sound_enabled = false

################################################################
func _ready():
	await get_tree().create_timer(0.2).timeout
	sound_enabled = true

################################################################
func _on_focus_entered():
	if sound_enabled:
		audio_click.play()
	_move_btn(-10)

func _on_focus_exited():
	_move_btn(0)

################################################################
func _move_btn(movement):
	var new_position = Vector2(movement, position.y)
	var tween = get_tree().create_tween()
	tween.tween_property(
		self,
		'position',
		new_position,
		0.1
	)
