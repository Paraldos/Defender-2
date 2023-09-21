extends Node2D

@export var rotation_speed = 0

@onready var hitbox = $Hitbox

var dmg = 5
var movement = Vector2(300, 0)
var target = 'player'
var projectile_color = Color("ffffff")

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
	if rotation_speed != 0:
		rotate(rotation_speed * delta)

###############################################################################
func _on_hitbox_area_entered(_area):
	SfxController._spawn_explosion_01(global_position)
	queue_free()

###############################################################################
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
