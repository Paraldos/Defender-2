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
]
var possible_waves = [
	{name = "Fighters", spawn_time = 0.8, wave_time = 15},
	{name = "Asteroids", spawn_time = 0.5, wave_time = 10},
]
var current_wave = null

###############################################################################
func _ready():
	rng.randomize()

###############################################################################
func _on_wave_timer_timeout():
	current_wave = possible_waves.pick_random()
	wave_timer.start(current_wave.wave_time)
	spawn_timer.start(current_wave.spawn_time)

###############################################################################
func _on_spawn_timer_timeout():
	if current_wave == null: return
	###
	var spawn_position = spawn_point.global_position
	spawn_position.y = randi_range(40, 270 - 40)
	###
	match current_wave.name:
		'Fighters':
			_spawn_enemy(enemy_fighter, spawn_position)
		'Asteroids':
			var asteroid = asteroids.pick_random()
			_spawn_enemy(asteroid, spawn_position)

func _spawn_enemy(element, pos):
	var new = element.instantiate()
	new.global_position = pos
	get_tree().current_scene.add_child(new)


