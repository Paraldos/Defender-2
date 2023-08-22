extends Node2D

@export var hp = 5
@export var credits = 3
@onready var hurtbox = %Hurtbox
@onready var hitbox = %Hitbox
var rng = RandomNumberGenerator.new()
var credit = preload("res://Game/Collectible/credit.tscn")

###############################################################################
func _ready():
	rng.randomize()
	hurtbox.scale *= 1.1
	hitbox.scale *= 1.1

###############################################################################
func _process(_delta):
	pass

###############################################################################
func _on_hurtbox_hurt(_hitbox, dmg):
	hp -= dmg
	if hp <= 0:
		_destroy()

#########################
func _on_hitbox_area_entered(_area):
	_destroy()


#########################
func _destroy():
	for i in credits:
		call_deferred('_spawn_credit')
	SfxController._spawn_explosion_02(global_position)
	queue_free()

func _spawn_credit():
	var new = credit.instantiate()
	var credit_move_speed = 100
	new.global_position = global_position
	new.movement = Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1)) * credit_move_speed
	get_tree().current_scene.add_child(new)

###############################################################################
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
