extends "res://Game/Enemies/enemy_template.gd"

var direction = Vector2(-1.0, 1.0)
var speed = 300
var changing_direction = false
@onready var movement_timer = %MovementTimer

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
	if global_position.y <= 50 && !changing_direction && direction.y != 1.0:
		_change_direction(1.0)
		movement_timer.start()
	elif global_position.y >= 230 && !changing_direction && direction.y != -1.0:
		_change_direction(-1.0)
		movement_timer.start()
	position += Vector2(direction.x * speed, direction.y * speed / 3) * delta

#########################
func _on_movement_timer_timeout():
	if changing_direction: return
	_change_direction(direction.y * -1)
	movement_timer.start(rng.randf_range(1, 3))

#########################
func _change_direction(y_direction):
	var new_direction = Vector2(-1.0, y_direction)
	changing_direction = true
	await create_tween().tween_property(
		self,
		'direction',
		new_direction,
		0.3
	).finished
	changing_direction = false
