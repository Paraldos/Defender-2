extends Node2D

@onready var wave_timer = %WaveTimer
@onready var spawn_timer = %SpawnTimer
@onready var spawn_point = %SpawnPoint
@onready var enemies = %Enemies
@onready var bosses = %Bosses

@export var test_wave = -1
@export var waves_till_boss = 5
@export var test_boss = -1

@onready var viewport = get_viewport_rect().size
var rng = RandomNumberGenerator.new()
var asteroids_background = preload("res://Backgrounds/asteroids_background.tscn")
var debris_background = preload("res://Backgrounds/debris_background.tscn")
var current_wave = null
var wave_number = 0

###############################################################################
func _ready():
	Utils.player_death.connect(_on_player_death)
	rng.randomize()

func _on_player_death():
	_stop_everything()

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
	if current_wave: return
	var boss
	await get_tree().create_timer(3.0).timeout
	if test_boss > -1:
		boss = bosses.get_children()[test_boss].boss_package
	else:
		boss = bosses.get_children().pick_random().boss_package
	_spawn_element(boss, Vector2(-800, -800))

###############################################################################
func _on_spawn_timer_timeout():
	var enemy = _get_enemy()
	match current_wave.wave_name:
		'AttackDrones':
			var spawn_point = _get_spawn_position()
			for i in 3:
				_spawn_element(enemy, spawn_point)
				await get_tree().create_timer(0.3).timeout
		'Asteroids':
			_spawn_element(enemy)
		'GunShips': 
			var spawn_points = _get_multiple_spawn_points(3)
			for i in 3:
				_spawn_element(enemy, spawn_points[i-1])
				await get_tree().create_timer(1.0).timeout
		'Debris':
			_spawn_element(enemy)
		'Missiles':
			var spawn_points = _get_multiple_spawn_points(3)
			for i in 3:
				_spawn_element(enemy, spawn_points[i-1])
		'PirateFighters':
			var spawn_points = _get_multiple_spawn_points(3, 50)
			for i in 3:
				_spawn_element(enemy, spawn_points[i-1])
				await get_tree().create_timer(0.3).timeout
		'CrabShips':
			var spawn_points = _get_multiple_spawn_points(3)
			for i in 3:
				_spawn_element(enemy, spawn_points[i-1])
				await get_tree().create_timer(1.0).timeout
		'HeavyFighters':
			var margin = 20
			var spawn_points = [
				Vector2(spawn_point.global_position.x, -margin),
				Vector2(spawn_point.global_position.x, viewport.y + margin),
			] 
			for i in 2:
				_spawn_element(enemy, spawn_points[i-1])
				await get_tree().create_timer(1.0).timeout

##################### HELPER
func _get_enemy():
	return current_wave.enemy_packages.pick_random()

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
	var window_heigt = viewport.y
	var spawn_position = Vector2.ZERO
	spawn_position.x = spawn_point.global_position.x
	spawn_position.y = randi_range(0 + margin, window_heigt - margin)
	return spawn_position

func _spawn_element(element, pos = _get_spawn_position()):
	var new = element.instantiate()
	new.global_position = pos
	get_tree().current_scene.add_child(new)
