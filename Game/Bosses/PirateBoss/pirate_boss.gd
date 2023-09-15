extends "res://Game/Bosses/boss_template.gd"

@onready var weapons_01 = $Weapons01
@onready var weapons_02 = $Weapons02

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
		'_attack01',
		'_attack02'
	]
	await call(attacks.pick_random())
	return true

func _attack01():
	for i in 6:
		for weapon in weapons_01.get_children():
			weapon._attack()
		await get_tree().create_timer(0.2).timeout
	return true

func _attack02():
	for i in 3:
		for weapon in weapons_02.get_children():
			weapon._attack()
		await get_tree().create_timer(0.3).timeout
	return true
