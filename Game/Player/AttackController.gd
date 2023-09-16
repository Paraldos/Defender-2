extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer
var rng = RandomNumberGenerator.new()
var projectile = preload('res://Game/Projectile/player_projectile.tscn')
var attack_timer = 0
var attack_wait_time = 0.2

###############################################################################
func _ready():
	rng.randomize()

###############################################################################
func _physics_process(delta):
	attack_timer += delta
	if get_parent().controlls_enabled:
		if Input.is_action_pressed('ui_attack'):
			if attack_timer > attack_wait_time:
				_attack(global_position + Vector2(0, -4))
				_attack(global_position + Vector2(0, 4))
				attack_timer = 0

###############################################################################
func _attack(target_position):
	_animate_muzzleflash()
	_gun_sound()
	_spawn_bullet(target_position)

func _animate_muzzleflash():
	animation_player.play("flash")

func _gun_sound():
	audio_stream_player.pitch_scale = rng.randf_range(0.9, 1.1)
	audio_stream_player.play()

func _spawn_bullet(target_position):
	var new = projectile.instantiate()
	new.global_position = target_position
	get_tree().current_scene.add_child(new)
