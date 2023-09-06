extends Node2D

@onready var wave_timer = %WaveTimer
@onready var spawn_timer = %SpawnTimer
@onready var spawn_point = %SpawnPoint
@onready var enemies = %Enemies

var asteroids = [
	preload("res://Game/Enemies/asteroid_01.tscn"),
	preload("res://Game/Enemies/asteroid_02.tscn"),
	preload("res://Game/Enemies/asteroid_03.tscn"),
	preload("res://Game/Enemies/asteroid_04.tscn"),
	preload("res://Game/Enemies/asteroid_05.tscn"),
	preload("res://Game/Enemies/asteroid_06.tscn"),
	preload("res://Game/Enemies/asteroid_07.tscn"),
	preload("res://Game/Enemies/asteroid_08.tscn"),
	preload("res://Game/Enemies/asteroid_09.tscn"),
	preload("res://Game/Enemies/asteroid_10.tscn"),
	preload("res://Game/Enemies/asteroid_11.tscn"),
	preload("res://Game/Enemies/asteroid_12.tscn"),
	preload("res://Game/Enemies/explosive_asteroid.tscn"),
]
var debris = [
	preload("res://Game/Enemies/debris_01.tscn"),
	preload("res://Game/Enemies/debris_02.tscn"),
	preload("res://Game/Enemies/debris_03.tscn"),
	preload("res://Game/Enemies/debris_04.tscn"),
	preload("res://Game/Enemies/debris_05.tscn"),
	preload("res://Game/Enemies/debris_06.tscn"),
]
var enemy_fighter = preload("res://Game/Enemies/enemy_fighter.tscn")
var gun_ships = preload("res://Game/Enemies/gunship.tscn")
var missile = preload("res://Game/Enemies/missile.tscn")
var possible_waves = [
	{name = "Fighters", spawn_time = 1.3, wave_time = 12, after_wave_pause = 3},
	{name = "Asteroids", spawn_time = 0.5, wave_time = 20, after_wave_pause = 4},
	{name = "GunShips", spawn_time = 2.0, wave_time = 12, after_wave_pause = 3},
	{name = "Debris", spawn_time = 0.5, wave_time = 20, after_wave_pause = 4},
	{name = 'Missiles', spawn_time = 1.6, wave_time = 8, after_wave_pause = 3}
]
var possible_bosses = [
	{name = 'PirateBoss', node = preload('res://Game/Bosses/PirateBoss/pirate_boss.tscn')}
]
var rng = RandomNumberGenerator.new()
var asteroids_background = preload("res://Backgrounds/asteroids_background.tscn")
var debris_background = preload("res://Backgrounds/debris_background.tscn")

var current_wave = null
@export var test_wave = -1
@export var waves_till_boss = -1
var wave_number = 0

###############################################################################
func _ready():
	rng.randomize()

###############################################################################
func _on_wave_timer_timeout():
	_stop_everything()
	await _wait_between_waves()
	_pick_next_wave()
	_start_background()
	_start_new_wave()

func _stop_everything():
	wave_timer.stop()
	spawn_timer.stop()
	Utils.stop_wave.emit()

func _wait_between_waves():
	if current_wave:
		spawn_timer.stop()
		await get_tree().create_timer(current_wave.after_wave_pause).timeout
	return true

func _pick_next_wave():
	if test_wave > -1:
		current_wave = enemies.get_children()[test_wave]
	elif waves_till_boss != -1 and wave_number >= waves_till_boss:
		current_wave = null
	else:
		wave_number += 1
		current_wave = enemies.get_children().pick_random()

func _start_background():
	return
	if current_wave.background:
		_spawn_element(current_wave.background, Vector2.ZERO)

func _start_new_wave():
	if current_wave:
		wave_timer.start(current_wave.wave_time)
		spawn_timer.start(current_wave.spawn_time)

###############################################################################
func _spawn_boss():
	var boss = possible_bosses.pick_random()
	await get_tree().create_timer(2.0).timeout
	_spawn_element(boss.node, Vector2(-800, -800))

###############################################################################
func _on_spawn_timer_timeout():
	match current_wave.wave_name:
		'Fighters':
			var spawn_points = _get_multiple_spawn_points(2, 100)
			_spawn_element(enemy_fighter, spawn_points[0])
			await get_tree().create_timer(0.3).timeout
			_spawn_element(enemy_fighter, spawn_points[1])
		'Asteroids':
			var asteroid = asteroids.pick_random()
			_spawn_element(asteroid)
		'GunShips': 
			_spawn_element(gun_ships)
		'Debris':
			var myDebris = debris.pick_random()
			_spawn_element(myDebris)
		'Missiles':
			var spawn_points = _get_multiple_spawn_points(3)
			_spawn_element(missile, spawn_points[0])
			_spawn_element(missile, spawn_points[1])
			_spawn_element(missile, spawn_points[2])

###############################################################################
func _get_multiple_spawn_points(number_of_positions = 1, distance_between_points = 25):
	var points = []
	while points.size() < number_of_positions:
		var newPoint = _get_spawn_position()
		if points.size() <= 0:
			points.append(newPoint)
			continue
		for point in points:
			if abs(point.y - newPoint.y) < distance_between_points:
				newPoint = false
				break
		if newPoint:
			points.append(newPoint)
	return points

func _get_spawn_position(y_deviation = 120):
	var spawn_position = spawn_point.global_position
	spawn_position.y += randi_range(-y_deviation, y_deviation)
	return spawn_position

func _spawn_element(element, pos = _get_spawn_position()):
	var new = element.instantiate()
	new.global_position = pos
	get_tree().current_scene.add_child(new)
