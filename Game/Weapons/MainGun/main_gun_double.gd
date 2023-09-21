extends "res://Game/Weapons/weapon_template.gd"

@export var offset = 5

@onready var animation_player = $AnimationPlayer

func _attack():
	animation_player.play("Attack")
	_play_attack_sound()
	_spawn_projectile(Vector2(0, offset))
	_spawn_projectile(Vector2(0, -offset))
