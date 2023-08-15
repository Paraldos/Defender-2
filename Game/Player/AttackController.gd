extends Node2D

@onready var animation_player = $AnimationPlayer
@export var dmg = 1
var projectile = preload('res://Game/Projectile/player_projectile.tscn')
var attack_timer = 0
var attack_wait_time = 0.2

func _physics_process(delta):
	attack_timer += delta
	if Input.is_action_pressed('ui_attack'):
		if attack_timer > attack_wait_time:
			_attack()
			attack_timer = 0

func _attack():
	animation_player.play("flash")
	var new = projectile.instantiate()
	new.global_position = global_position
	get_tree().current_scene.add_child(new)
