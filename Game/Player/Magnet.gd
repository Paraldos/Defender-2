extends Area2D

@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	var radius_bonus = Utils.player.magnet * 5
	collision_shape_2d.shape.radius = 55 + radius_bonus
