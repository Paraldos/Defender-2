extends Node2D

var projectile = preload('res://Game/Projectile/pulse_projectile.tscn')
@export var projectile_speed = 200
@onready var audio_stream_player = $AudioStreamPlayer

func _attack():
	_spawn_projectile(Vector2(projectile_speed, projectile_speed))
	_spawn_projectile(Vector2(projectile_speed, -projectile_speed))
	_spawn_projectile(Vector2(-projectile_speed, projectile_speed))
	_spawn_projectile(Vector2(-projectile_speed, -projectile_speed))
	audio_stream_player.play()

func _spawn_projectile(movemenet):
	var new = projectile.instantiate()
	new.global_position = global_position
	new.movement = movemenet
	get_tree().current_scene.add_child(new)
