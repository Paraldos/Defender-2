extends "res://Game/Enemies/enemy_template.gd"

@export var speed = Vector2(-200, 0)
@onready var weapons = [
	$BubbleGun,
	$BubbleGun2,
]

###############################################################################
func _process(delta):
	super._process(delta)
	_move(delta)

#########################
func _move(delta):
	global_position += speed * delta

###############################################################################
func _on_attack_timer_timeout():
	for i in 3:
		for weapon in weapons:
			weapon._attack()
		await get_tree().create_timer(0.4).timeout
