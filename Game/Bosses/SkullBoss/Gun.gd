extends Node2D

func _process(delta):
	look_at(Utils.player.position)
