extends "res://Game/Projectile/projectile.gd"

func _ready():
	super._ready()
	look_at(global_position + movement)
	hitbox.dmg = Utils.player.dmg + Utils.player.gun
