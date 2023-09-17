extends Node2D

func _process(_delta):
	look_at(Utils.player.position)
