extends Node2D

@export var hp = 5
@export var credits = 1
var rng = RandomNumberGenerator.new()

###############################################################################
func _ready():
	rng.randomize()

###############################################################################
func _process(_delta):
	pass

###############################################################################
func _on_hurtbox_hurt(hitbox, dmg):
	hp -= dmg
	if hp <= 0:
		_destroy()

#########################
func _on_hitbox_area_entered(area):
	_destroy()

#########################
func _destroy():
	SfxController._spawn_explosion_02(global_position)
	queue_free()

###############################################################################
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
