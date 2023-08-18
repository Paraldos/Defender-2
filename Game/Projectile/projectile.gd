extends Node2D

var SPEED = Vector2(300, 0)

func _process(delta):
	_move(delta)

func _move(delta):
	position += SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_hitbox_area_entered(area):
	SfxController._spawn_explosion_01(global_position)
	queue_free()
