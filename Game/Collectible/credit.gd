extends "res://Game/Collectible/CollectibleTemplate.gd"

func _on_body_entered(_body):
	Utils.player.credits += 5
	SfxController._spawn_explosion_04(global_position)
	queue_free()