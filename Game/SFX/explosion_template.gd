extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	rotation = rng.randf_range(-10, 10)

