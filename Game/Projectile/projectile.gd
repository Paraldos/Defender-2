extends Node2D

@export var movement = Vector2(300, 0)
@onready var hitbox = %Hitbox

###############################################################################
func _ready():
	look_at(global_position + movement)

###############################################################################
func _process(delta):
	position += movement * delta

###############################################################################
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

###############################################################################
func _on_hitbox_area_entered(_area):
	SfxController._spawn_explosion_01(global_position)
	queue_free()
