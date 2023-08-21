extends "res://Game/Enemies/enemy_template.gd"

var movement = Vector2(-100, 0)

###############################################################################
func _ready():
	super._ready()
	movement.y = rng.randf_range(-10, 10)

###############################################################################
func _process(delta):
	super._process(delta)
	_move()

#########################
func _move():
	global_position += movement
