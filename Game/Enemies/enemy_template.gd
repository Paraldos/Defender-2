extends Node2D

@export var hp = 5
@export var credits = 3
@export var disable_screen_notifier_delete = false
@onready var hurtbox = %Hurtbox
@onready var hitbox = %Hitbox
var rng = RandomNumberGenerator.new()

###############################################################################
func _ready():
	rng.randomize()
	Utils.stage.enemies_total += 1
	_adapt_collision_boxes()

func _adapt_collision_boxes():
	hurtbox.scale *= 1.1
	hitbox.scale *= 1.1

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

func _on_hitbox_area_entered(_area):
	_destroy()

func _destroy():
	call_deferred('_spawn_treasure')
	SfxController._spawn_explosion_02(global_position)
	Utils.stage.enemies_killed += 1
	queue_free()

func _spawn_treasure():
	Utils.spawn_treasure.emit(credits, global_position)

###############################################################################
func _on_visible_on_screen_notifier_2d_screen_exited():
	if disable_screen_notifier_delete:
		return
	else:
		queue_free()
