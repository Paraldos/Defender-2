extends Node2D

@onready var wave_timer = %WaveTimer
@onready var spawn_timer = %SpawnTimer
@onready var spawn_point = %SpawnPoint
@onready var enemies = %Enemies
@onready var bosses = %Bosses

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
	_pick_next_wave()
	await _wait_between_waves()
	_start_background()
	_start_new_wave()
	_start_boss_fight()

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
	if current_wave and current_wave.background:
		_spawn_element(current_wave.background, Vector2.ZERO)

func _start_new_wave():
	if current_wave:
		wave_timer.start(current_wave.wave_time)
		spawn_timer.start(current_wave.spawn_time)

func _start_boss_fight():
	if !current_wave:
		await get_tree().create_timer(3.0).timeout
		var boss = bosses.get_children().pick_random().boss_package
		_spawn_element(boss, Vector2(-800, -800))

###############################################################################
func _on_spawn_timer_timeout():
	match current_wave.wave_name:
		'AttackDrones':
			var enemy = current_wave.enemy_packages.pick_random()
			var spawn_points = _get_multiple_spawn_points(2, 100)
			_spawn_element(enemy, spawn_points[0])
			await get_tree().create_timer(0.3).timeout
			_spawn_element(enemy, spawn_points[1])
		'Asteroids':
			var enemy = current_wave.enemy_packages.pick_random()
			_spawn_element(enemy)
		'GunShips': 
			var enemy = current_wave.enemy_packages.pick_random()
			_spawn_element(enemy)
		'Debris':
			var enemy = current_wave.enemy_packages.pick_random()
			_spawn_element(enemy)
		'Missiles':
			var enemy = current_wave.enemy_packages.pick_random()
			var spawn_points = _get_multiple_spawn_points(3)
			_spawn_element(enemy, spawn_points[0])
			_spawn_element(enemy, spawn_points[1])
			_spawn_element(enemy, spawn_points[2])
		'PirateFighters':
			var enemy = current_wave.enemy_packages.pick_random()
			var spawn_points = _get_multiple_spawn_points(3, 50)
			_spawn_element(enemy, spawn_points[0])
			_spawn_element(enemy, spawn_points[1])
			_spawn_element(enemy, spawn_points[2])

##################### HELPER
func _get_multiple_spawn_points(number_of_positions = 1, distance_between_points = 25):
	var points = []
	points.append(_get_spawn_position())
	while points.size() < number_of_positions:
		var newPoint = _get_spawn_position()
		for point in points:
			if point.distance_to(newPoint) < distance_between_points:
				newPoint = false
				break
		if newPoint:
			points.append(newPoint)
	return points

func _get_spawn_position(margin = 20):
	var window_heigt = 270
	var spawn_position = Vector2.ZERO
	spawn_position.x = spawn_point.global_position.x
	spawn_position.y = randi_range(0 + margin, window_heigt - margin)
	return spawn_position

func _spawn_element(element, pos = _get_spawn_position()):
	var new = element.instantiate()
	new.global_position = pos
	get_tree().current_scene.add_child(new)
