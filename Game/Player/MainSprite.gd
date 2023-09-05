extends Sprite2D

@onready var animation_tree = $AnimationTree

func _move_animation(target_blend_position):
	var tween = create_tween()
	tween.tween_property(
		animation_tree,
		"parameters/blend_position",
		target_blend_position,
		0.1
	)
