extends "res://Game/Collectible/CollectibleTemplate.gd"

func _on_body_entered(_body):
	Utils.player.credits += 25
	SfxController._spawn_explosion_04(global_position)
	queue_free()
