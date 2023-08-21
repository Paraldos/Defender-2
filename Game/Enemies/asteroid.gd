extends "res://Game/Enemies/enemy_template.gd"

var movement = Vector2(-150, 0)
var spin = 0

###############################################################################
func _ready():
	super._ready()
	movement.y = rng.randf_range(-30, 30)
	spin = rng.randf_range(-1, 1)
	scale *= rng.randi_range(0.8, 1.2)

###############################################################################
func _process(delta):
	super._process(delta)
	_move(delta)
	_spin(delta)

#########################
func _move(delta):
	global_position += movement * delta

#########################
func _spin(delta):
	rotation += spin * delta
