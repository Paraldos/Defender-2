class_name Hitbox
extends Area2D

@export var dmg = 1

func _on_area_entered(hurtbox):
	if not hurtbox is Hurtbox: return
	hurtbox._take_hit(self, dmg)
