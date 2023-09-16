extends "res://Game/Bosses/boss_template.gd"

var move_time = 2.0
var move_margin = 75
@onready var weapons_01 = $Weapons01
@onready var weapons_02 = $Gun/Weapons02

###############################################################################
func _attack():
	await _move()
	return true

###############################################################################
func _move():
	var target_position = Vector2(
		_get_target_position_x(), 
		_get_target_position_y())
	_attack_move()
	await create_tween().tween_property(
		self,
		'global_position',
		target_position,
		move_time
	).finished
	return true

func _get_target_position_x():
	return rng.randi_range(360, 440)

func _get_target_position_y():
	if global_position.y >= 270/2:
		return 75
	else:
		return 270 - 50 

###############################################################################
func _attack_move():
	var attacks = [
		'_attack01',
		'_attack02'
	]
	await call(attacks.pick_random())
	return true

func _attack01():
	for weapon in weapons_01.get_children():
		weapon._attack()

func _attack02():
	for i in 3:
		for weapon in weapons_02.get_children():
			weapon._attack()
			await  get_tree().create_timer(0.1).timeout


