extends "res://Game/Projectile/projectile.gd"

func _ready():
	super._ready()
	hitbox.dmg = Utils.player.dmg
