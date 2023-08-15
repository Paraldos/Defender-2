extends Area2D

var SPEED = Vector2(300, 0)

func _ready():
	pass

func _process(delta):
	_move(delta)

func _move(delta):
	position += SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	print('Hi')
	queue_free()
