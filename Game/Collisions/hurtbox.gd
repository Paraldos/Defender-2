class_name Hurtbox
extends Area2D

signal hurt(hitbox, dmg)

func _take_hit(hitbox, dmg):
	hurt.emit(hitbox, dmg)
