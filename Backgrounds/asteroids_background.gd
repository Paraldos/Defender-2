extends Node2D

@onready var particles = %Particles

func _ready():
	Utils.stop_wave.connect(_on_stop_wave)

func _on_stop_wave():
	particles.emitting = false
	await get_tree().create_timer(15).timeout
	queue_free()
