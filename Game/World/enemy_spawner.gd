extends Node2D

@onready var wave_timer = %WaveTimer
@onready var spawn_timer = %SpawnTimer
@onready var spawn_point = %SpawnPoint

var rng = RandomNumberGenerator.new()
var enemy_fighter = preload("res://Game/Enemies/enemy_fighter.tscn")
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
	{name = "Fighters", spawn_time = 1.5, wave_time = 15, after_wave_pause = 3},
	{name = "Asteroids", spawn_time = 0.5, wave_time = 30, after_wave_pause = 3},
]
var asteroids_background = preload("res://Backgrounds/asteroids_background.tscn")
var current_wave = null
var test_wave = 1

###############################################################################
func _ready():
	rng.randomize()

###############################################################################
func _on_wave_timer_timeout():
	Utils.stop_wave.emit()
	if current_wave != null:
		spawn_timer.stop()
		await get_tree().create_timer(current_wave.after_wave_pause).timeout
	###
	if test_wave != null:
		current_wave = possible_waves[test_wave]
	else:
		current_wave = possible_waves.pick_random()
	###
	if current_wave.name == 'Asteroids':
		_spawn_element(asteroids_background, Vector2.ZERO)
	###
	wave_timer.start(current_wave.wave_time)
	spawn_timer.start(current_wave.spawn_time)

###############################################################################
func _on_spawn_timer_timeout():
	var spawn_position = spawn_point.global_position
	spawn_position.y = randi_range(40, 270 - 40)
	###
	match current_wave.name:
		'Fighters':
			_spawn_element(enemy_fighter, spawn_position)
		'Asteroids':
			var asteroid = asteroids.pick_random()
			_spawn_element(asteroid, spawn_position)

func _spawn_element(element, pos):
	var new = element.instantiate()
	new.global_position = pos
	get_tree().current_scene.add_child(new)


