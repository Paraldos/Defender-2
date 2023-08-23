extends "res://Game/Collectible/CollectibleTemplate.gd"

func _on_body_entered(body):
	Utils.player.hp = clamp(Utils.player.hp +10, 0, Utils.player.max_hp)
	SfxController._spawn_explosion_04(global_position)
	Utils.change_hp.emit()
	queue_free()
