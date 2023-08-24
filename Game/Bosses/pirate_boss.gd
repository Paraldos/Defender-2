extends "res://Game/Bosses/boss_template.gd"

@onready var wing_guns = [
	$NormalGunController,
	$NormalGunController2,
	$NormalGunController3,
	$NormalGunController4,
]

###############################################################################
func _move():
	var target_position = Vector2(
		_get_target_position_x(), 
		_get_target_position_y())
	await create_tween().tween_property(
		self,
		'global_position',
		target_position,
		0.5
	).finished
	return true

func _get_target_position_x():
	return rng.randi_range(320, 440)

func _get_target_position_y():
	if global_position.y >= 270/2:
		return rng.randf_range(40, 130)
	else:
		return rng.randf_range(140, 250)

###############################################################################
func _attack():
	var attacks = [
		await _attack0()
	]
	attacks.pick_random()
	return true

func _attack0():
	wing_guns[0]._attack()
	wing_guns[1]._attack()
	wing_guns[2]._attack()
	await wing_guns[3]._attack()
	return true

###############################################################################
func _on_normal_gun_controller_attack_done():
	_move()
