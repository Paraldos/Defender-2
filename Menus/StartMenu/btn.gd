extends Button

################################################################
func _on_focus_entered():
	_move_btn(-10)

func _on_focus_exited():
	_move_btn(0)

func _move_btn(movement):
	var new_position = Vector2(movement, position.y)
	var tween = get_tree().create_tween()
	tween.tween_property(
		self,
		'position',
		new_position,
		0.1
	)
