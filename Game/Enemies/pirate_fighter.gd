extends "res://Game/Enemies/enemy_template.gd"

var speed = 300

###############################################################################
func _process(delta):
	super._process(delta)
	_movement(delta)

#########################
func _movement(delta):
	position += Vector2(-speed, 0) * delta
