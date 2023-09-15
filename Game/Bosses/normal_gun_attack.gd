extends Node2D

var projectile = preload('res://Game/Projectile/enemy_projectile.tscn')
@onready var muzzle = $Muzzle
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer

func _attack():
	animation_player.play("Attack")
	audio_stream_player.pitch_scale = randf_range(0.8, 1.2)
	audio_stream_player.play()

func _spawn_projectile():
	var new = projectile.instantiate()
	new.global_position = muzzle.global_position
	get_tree().current_scene.add_child(new)
