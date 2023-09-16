extends Node2D

@export var hp = 5
@export var credits = 3
@export var disable_screen_notifier_delete = false

@onready var hurtbox = %Hurtbox
@onready var hitbox = %Hitbox
@onready var animation_player = $Hurtbox/AnimationPlayer

var rng = RandomNumberGenerator.new()
var exploding = false

###############################################################################
func _ready():
	rng.randomize()
	Utils.stage.enemies_spawned += 1
	Utils.total.enemies_spawned += 1
	hp += Utils.total.completed
	_adapt_collision_boxes()

func _adapt_collision_boxes():
	hurtbox.scale *= 1.1
	hitbox.scale *= 1.1

###############################################################################
func _process(_delta):
	pass

###############################################################################
func _on_hurtbox_hurt(_hitbox, dmg):
	animation_player.play("hit")
	hp -= dmg
	if hp <= 0 and !exploding:
		_destroy()

func _on_hitbox_area_entered(_area):
	_destroy()

func _destroy():
	exploding = true
	call_deferred('_spawn_treasure')
	SfxController._spawn_explosion_02(global_position)
	Utils.stage.enemies_killed += 1
	Utils.total.enemies_killed += 1
	queue_free()

func _spawn_treasure():
	Utils.spawn_treasure.emit(credits, global_position)

###############################################################################
func _on_visible_on_screen_notifier_2d_screen_exited():
	if disable_screen_notifier_delete:
		return
	else:
		queue_free()
