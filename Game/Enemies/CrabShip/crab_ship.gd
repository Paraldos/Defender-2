extends "res://Game/Enemies/enemy_template.gd"

var speed = 200
@onready var bubble_gun = $BubbleGun

###############################################################################
func _process(delta):
	super._process(delta)
	_movement(delta)

#########################
func _movement(delta):
	position += Vector2(-speed, 0) * delta

###############################################################################
func _on_attack_timer_timeout():
	for i in 3:
		bubble_gun._attack()
		await get_tree().create_timer(0.2).timeout

