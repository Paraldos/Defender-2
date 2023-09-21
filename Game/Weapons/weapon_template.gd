extends Node2D

@export var projectile : PackedScene
@export var projectile_speed = 300
@export var dmg = 5
@export_enum('player', 'enemy') var target = 'player'
@export var rand_projectile_offset = Vector2.ZERO
@export var projectile_color = Color("ffffff")

@onready var ray_cast_to_target = %RayCastToTarget
@onready var attack_audio = $AttackAudio

var rng = RandomNumberGenerator.new()

##############################################################################
func _ready():
	rng.randomize()

##############################################################################
func _process(delta):
	pass

##############################################################################
# overwrite
func _attack():
	_spawn_projectile()
	_play_attack_sound()

func _play_attack_sound(variance = 0.2):
	attack_audio.pitch_scale = rng.randf_range(1.0 -variance, 1.0 +variance)
	attack_audio.play()

#################################
func _spawn_projectile(spawn_offset = Vector2.ZERO):
	var new_projectile = projectile.instantiate()
	new_projectile.global_position = global_position + (
		spawn_offset + (rand_projectile_offset * rng.randf_range(-1, 1)))
	new_projectile.movement = global_position.direction_to(
		to_global(ray_cast_to_target.target_position)) * projectile_speed
	new_projectile.dmg = dmg
	new_projectile.target = target
	new_projectile.projectile_color = projectile_color
	get_tree().current_scene.add_child(new_projectile)
