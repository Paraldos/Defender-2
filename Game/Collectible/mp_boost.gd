extends "res://Game/Collectible/CollectibleTemplate.gd"

func _on_body_entered(_body):
	Utils.player.ep = clamp(Utils.player.ep +25, 0, Utils.player.max_ep)
	SfxController._spawn_explosion_04(global_position)
	Utils.change_ep.emit()
	queue_free()
