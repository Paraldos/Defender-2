extends Node2D

@export var hp = 5

func _ready():
	pass

func _process(_delta):
	pass

func _on_hurtbox_hurt(hitbox, dmg):
	hp -= dmg
	if hp <= 0:
		queue_free()
