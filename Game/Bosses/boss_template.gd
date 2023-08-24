extends Node2D

@export var hp = 100
@export var invulnerable = true
@onready var hurtbox_animation_player = $Hurtbox/HurtboxAnimationPlayer
var rng = RandomNumberGenerator.new()

###############################################################################
func _ready():
	rng.randomize()
	Utils.change_background_speed.emit(Vector2.ZERO)
	global_position = Vector2(480+200, 270/2)
	_move_in(Vector2(480-100, 270/2))

###########################
func _move_in(target_position):
	var tween = create_tween()
	await tween.tween_property(self, 'global_position', target_position, 3).finished
	await get_tree().create_timer(1).timeout
	_start_fight()

func _start_fight():
	pass

###############################################################################
func _process(delta):
	pass

###############################################################################
func _on_hurtbox_hurt(hitbox, dmg):
	if !invulnerable:
		hurtbox_animation_player.play("hit")
		hp -= dmg
	if hp <= 0:
		_death()

###########################
func _death():
	pass
