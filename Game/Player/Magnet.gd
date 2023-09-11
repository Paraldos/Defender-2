extends Area2D

@onready var magnet_collision = $MagnetCollision

func _ready():
	var radius_bonus = Utils.player.magnet * 5
	magnet_collision.shape.radius = 55 + radius_bonus
