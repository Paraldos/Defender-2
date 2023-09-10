extends "res://Game/Projectile/projectile.gd"

@onready var main_sprite = $MainSprite

func _process(delta):
	super._process(delta)
	main_sprite.rotation += 5 * delta
