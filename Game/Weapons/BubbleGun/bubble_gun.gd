extends "res://Game/Weapons/weapon_template.gd"

func _attack():
	_spawn_projectile()
	_play_attack_sound()
