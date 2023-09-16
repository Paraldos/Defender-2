extends "res://Game/Enemies/enemy_template.gd"

var speed = 200
var projectile = preload('res://Game/Projectile/crab_projectile.tscn')
@onready var muzzle = $Muzzle
@onready var audio_stream_player = $AudioStreamPlayer

###############################################################################
func _process(delta):
	super._process(delta)
	_movement(delta)

#########################
func _movement(delta):
	position += Vector2(-speed, 0) * delta

###############################################################################
func _on_attack_timer_timeout():
	for i in 3:
		_attack_audio()
		_spawn_projectile()
		await get_tree().create_timer(0.2).timeout

func _attack_audio():
	audio_stream_player.pitch_scale = rng.randf_range(0.8, 1.2)
	audio_stream_player.play()

func _spawn_projectile():
	var new = projectile.instantiate()
	new.dmg = dmg
	new.global_position =  Vector2(
		muzzle.global_position.x,
		muzzle.global_position.y + rng.randi_range(-6, 6)
	)
	get_tree().current_scene.add_child(new)

