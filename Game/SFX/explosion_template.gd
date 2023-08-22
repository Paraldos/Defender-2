extends Node2D

var rng = RandomNumberGenerator.new()
@export var screen_shake = 0.0

func _ready():
	rng.randomize()
	rotation = rng.randf_range(-10, 10)
	if screen_shake > 0:
		Utils.screen_shake.emit(screen_shake, 0.2)
