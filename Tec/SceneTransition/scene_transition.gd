extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _change_scene(new_scene : String):
	animation_player.play("FadeIn")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(new_scene)
	animation_player.play_backwards("FadeIn")
	await animation_player.animation_finished
	Utils.scene_transition_done.emit()
