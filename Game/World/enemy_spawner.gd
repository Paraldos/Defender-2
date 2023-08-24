extends Node2D

@onready var wave_timer = %WaveTimer
@onready var spawn_timer = %SpawnTimer
@onready var spawn_point = %SpawnPoint

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
var possible_waves = [
	{name = "Fighters", spawn_time = 1.3, wave_time = 15, after_wave_pause = 3},
	{name = "Asteroids", spawn_time = 0.5, wave_time = 30, after_wave_pause = 3},
	{name = "GunShips", spawn_time = 2.0, wave_time = 15, after_wave_pause = 3},
]
var possible_bosses = [
	{name = 'PirateBoss', node = preload('res://Game/Bosses/pirate_boss.tscn')}
]
var rng = RandomNumberGenerator.new()
var enemy_fighter = preload("res://Game/Enemies/enemy_fighter.tscn")
var gun_ships = preload("res://Game/Enemies/gunship.tscn")
var asteroids_background = preload("res://Backgrounds/asteroids_background.tscn")
var current_wave = null
@export var test_wave = -1
@export var waves_till_boss = -1
var wave_number = 0

###############################################################################
func _ready():
	rng.randomize()

###############################################################################
func _on_wave_timer_timeout():
	Utils.stop_wave.emit()
	####### wait timer between waves
	if current_wave != null:
		spawn_timer.stop()
		await get_tree().create_timer(current_wave.after_wave_pause).timeout
	####### determinen next new wave
	if test_wave > -1: # specific testwave
		current_wave = possible_waves[test_wave]
	elif waves_till_boss != -1 and wave_number >= waves_till_boss: # boss
		current_wave = null
		_spawn_boss()
	else: # normal randome wave
		wave_number += 1
		current_wave = possible_waves.pick_random()
	####### spawn new wave
	if current_wave != null:
		wave_timer.start(current_wave.wave_time)
		spawn_timer.start(current_wave.spawn_time)
		if current_wave.name == 'Asteroids':
			_spawn_element(asteroids_background, Vector2.ZERO)
	else:
		wave_timer.stop()
		spawn_timer.stop()

func _spawn_boss():
	var boss = possible_bosses.pick_random()
	await get_tree().create_timer(2.0).timeout
	_spawn_element(boss.node, Vector2(-800, -800))

###############################################################################
func _on_spawn_timer_timeout():
	match current_wave.name:
		'Fighters':
			_spawn_element(enemy_fighter)
			await get_tree().create_timer(0.3).timeout
			_spawn_element(enemy_fighter)
		'Asteroids':
			var asteroid = asteroids.pick_random()
			_spawn_element(asteroid)
		'GunShips': 
			_spawn_element(gun_ships)

func _get_spawn_position(y_deviation = 100):
	var spawn_position = spawn_point.global_position
	spawn_position.y += randi_range(-y_deviation, y_deviation)
	return spawn_position

func _spawn_element(element, pos = _get_spawn_position()):
	var new = element.instantiate()
	new.global_position = pos
	get_tree().current_scene.add_child(new)
