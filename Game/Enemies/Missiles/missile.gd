extends "res://Game/Enemies/enemy_template.gd"

func _move():
	create_tween().tween_property(
		self,
		'global_position',
		global_position + Vector2(-700, 0),
		0.5
	)
