extends "res://Game/Bosses/boss_template.gd"

@onready var wing_guns = [
	$NormalGunController,
	$NormalGunController2,
	$NormalGunController3,
	$NormalGunController4,
]
var waittime_between_actions = 0.3

###############################################################################
func _start_fight():
	_move()

###############################################################################
func _move():
	var target_position = Vector2.ZERO
	target_position.x = rng.randi_range(320, 440)
	target_position.y = _get_target_y_position()
	###
	var tween = create_tween()
	await tween.tween_property(
		self,
		'global_position',
		target_position,
		0.5
	).finished
	###
	await get_tree().create_timer(waittime_between_actions).timeout
	_attack()

###########################
func _get_target_y_position():
	if global_position.y >= 270/2:
		return rng.randf_range(40, 130)
	else:
		return rng.randf_range(140, 250)

###############################################################################
func _attack():
	for i in 1:
		match i:
			0:
				_attack0()

###########################
func _attack0():
	for gun in wing_guns:
		gun._attack()

###############################################################################
func _on_normal_gun_controller_attack_done():
	await get_tree().create_timer(waittime_between_actions).timeout
	_move()
