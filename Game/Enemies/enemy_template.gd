extends Node2D

@export var hp = 5
@export var credits_factor = 1
var credits = 2
@onready var hurtbox = %Hurtbox
@onready var hitbox = %Hitbox
var rng = RandomNumberGenerator.new()
var credit = preload("res://Game/Collectible/credit.tscn")
var powerups = [
	preload("res://Game/Collectible/hp_boost.tscn"),
	preload("res://Game/Collectible/ep_boost.tscn")
]

###############################################################################
func _ready():
	rng.randomize()
	Utils.stage.enemies_total += 1
	hurtbox.scale *= 1.1
	hitbox.scale *= 1.1
	credits = floor(hp / 5 * credits_factor)

###############################################################################
func _process(_delta):
	pass

###############################################################################
func _on_hurtbox_hurt(_hitbox, dmg):
	hp -= dmg
	modulate = Color('000000')
	create_tween().tween_property(
		self,
		'modulate',
		Color('ffffff'),
		0.3
	)
	if hp <= 0:
		_destroy()

#########################
func _on_hitbox_area_entered(_area):
	_destroy()

#########################
func _destroy():
	for i in credits:
		call_deferred('_spawn_credit')
	call_deferred('_spawn_powerup')
	SfxController._spawn_explosion_02(global_position)
	Utils.stage.enemies_killed += 1
	queue_free()

#########################
func _spawn_powerup():
	if Utils.powerup:
		Utils._start_powerup_timer()
		var element = powerups.pick_random()
		var new = element.instantiate()
		new.global_position = global_position
		get_tree().current_scene.add_child(new)

#########################
func _spawn_credit():
	var new = credit.instantiate()
	var credit_move_speed = 100
	new.global_position = global_position
	new.movement = Vector2(
		rng.randf_range(-1, 1), 
		rng.randf_range(-1, 1)
		) * credit_move_speed
	get_tree().current_scene.add_child(new)

###############################################################################
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
