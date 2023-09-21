extends Node2D

@export var dmg = 5
@export var movement = Vector2(300, 0)
@export var target = 'player'
@export var projectile_color = Color("ffffff")

@onready var hitbox = $Hitbox

###############################################################################
func _ready():
	look_at(global_position + movement)
	modulate = projectile_color
	hitbox.dmg = dmg
	match target:
		'player':
			hitbox.collision_mask = 2
		'enemy':
			hitbox.collision_mask = 4

###############################################################################
func _process(delta):
	position += movement * delta

###############################################################################
func _on_hitbox_area_entered(_area):
	SfxController._spawn_explosion_01(global_position)
	queue_free()

###############################################################################
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
