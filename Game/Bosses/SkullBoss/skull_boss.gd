extends "res://Game/Bosses/boss_template.gd"

var move_time = 2.0
var move_margin = 75
@onready var weapons_01 = $Weapons01
@onready var weapons_01_lines = %Weapons01_Lines
@onready var weapons_01_lasers = %Weapons01_Lasers
@onready var weapons_02 = $Gun/Weapons02

###############################################################################
func _ready():
	super._ready()
	_enable_laser_lines(false)

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
	_enable_laser_lines(true)
	await get_tree().create_timer(0.5).timeout
	_laser_attack()
	_enable_laser_lines(false)

func _enable_laser_lines(new_status : bool):
	for line in weapons_01_lines.get_children():
		line.visible = new_status

func _laser_attack():
	for weapon in weapons_01_lasers.get_children():
		weapon._attack(0.5)

func _attack02():
	for i in 3:
		for weapon in weapons_02.get_children():
			weapon._attack()
			await  get_tree().create_timer(0.1).timeout
