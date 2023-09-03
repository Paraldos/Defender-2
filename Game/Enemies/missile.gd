extends "res://Game/Enemies/enemy_template.gd"

@onready var line = %Line
var move = false
var speed = 1000

func _ready():
	line.modulate = Color('ffffff00')
	await _change_line_color(Color('ffffff'), 0.5)
	await get_tree().create_timer(0.6).timeout
	move = true
	_change_line_color(Color('ffffff00'), 0.6)

func _change_line_color(target_color, time):
	await create_tween().tween_property(line, 'modulate', target_color, time ).finished
	return true

func _process(delta):
	if move:
		global_position += Vector2(-1,0) * speed * delta
		line.global_position.x = 0
