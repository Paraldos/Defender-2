extends Node2D

@onready var sprite_laser = $SpriteLaser
@onready var muzzle_animation_player = $SpriteMuzzle/MuzzleAnimationPlayer
@onready var hitbox = $Hitbox
@onready var audio_stream_player = $AudioStreamPlayer

@export var dmg = 5
@export_enum('player', 'enemy') var target = 'player'
var attack_timer = 0

##############################################################################
func _ready():
	_enable_laser(false)
	match target:
		'player':
			hitbox.collision_mask = 2
		'enemy':
			hitbox.collision_mask = 4

##############################################################################
func _attack(laser_time : float):
	audio_stream_player.play()
	_muzzle_flash()
	_enable_laser(true)
	await get_tree().create_timer(laser_time).timeout
	_enable_laser(false)

func _muzzle_flash():
	muzzle_animation_player.play("flash")
	muzzle_animation_player.animation_finished

func _enable_laser(new_status : bool):
	sprite_laser.visible = new_status
	hitbox.monitoring = new_status

##############################################################################
func _physics_process(delta):
	attack_timer += delta
	_deal_dmg()

func _deal_dmg():
	if !hitbox.monitoring: return
	if attack_timer < 0.1: return
	for area in hitbox.get_overlapping_areas():
		if not area is Hurtbox: return
		area._take_hit(self, dmg)
		attack_timer = 0
		SfxController._spawn_explosion_01(area.global_position)
