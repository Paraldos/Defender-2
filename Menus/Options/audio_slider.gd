extends HBoxContainer

@export var bus_name : String
@onready var bus_index = AudioServer.get_bus_index(bus_name)
@onready var h_slider = $HSlider
@onready var audio_stream_player = $AudioStreamPlayer
@onready var label = $Label
var sound_enabled = false

func _ready():
	label.text = bus_name
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	audio_stream_player.bus = bus_name
	await get_tree().create_timer(0.1).timeout
	sound_enabled = true

func _on_h_slider_value_changed(value):
	if sound_enabled:
		audio_stream_player.play()
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _on_h_slider_focus_entered():
	if sound_enabled:
		audio_stream_player.play()
