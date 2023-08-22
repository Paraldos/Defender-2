extends "res://Game/Enemies/enemy_template.gd"

var direction = Vector2(-1.0, 1.0)
var speed = 200
var changing_direction = false

@onready var movement_timer = %MovementTimer
@onready var ray_cast_up = %RayCastUp
@onready var ray_cast_down = %RayCastDown

###############################################################################
func _ready():
	super._ready()
	if rng.randi_range(0, 1) == 1:
		direction.y *= -1

###############################################################################
func _process(delta):
	super._process(delta)
	_movement(delta)

#########################
func _movement(delta):
	if ray_cast_up.is_colliding() && !changing_direction && direction.y != 1.0:
		_change_direction(1.0)
		movement_timer.start()
	elif ray_cast_down.is_colliding() && !changing_direction && direction.y != -1.0:
		_change_direction(-1.0)
		movement_timer.start()
	position += Vector2(direction.x * speed, direction.y * speed / 2) * delta

#########################
func _on_movement_timer_timeout():
	_change_direction(direction.y * -1)
	movement_timer.start(rng.randf_range(1, 3))

#########################
func _change_direction(y_direction):
	var new_direction = Vector2(-1.0, y_direction)
	var tween = get_tree().create_tween()
	###
	changing_direction = true
	await tween.tween_property(
		self,
		'direction',
		new_direction,
		0.3
	).finished
	changing_direction = false
