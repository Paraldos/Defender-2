extends CharacterBody2D

const ACCELERATION = 3000.0
const MAX_SPEED = 400.0
var input = Vector2.ZERO
var invulnerable = false
@onready var main_sprite_animation_tree = $MainSprite/AnimationTree
@onready var hit_animation_player = %HitAnimationPlayer

############################################################
func _ready():
	await get_tree().create_timer(0.1).timeout
	Utils.player.node = self
	Utils.change_hp.emit()
	Utils.change_mp.emit()

############################################################
func _physics_process(delta):
	_get_input()
	_movement(delta)
	_movement_animation()
	Utils.player.position = global_position

###########################
func _movement_animation():
	var tween = get_tree().create_tween()
	tween.tween_property(
		main_sprite_animation_tree,
		"parameters/blend_position",
		input.y,
		0.1
	)

func _movement(delta):
	velocity.y = move_toward(velocity.y, input.y * MAX_SPEED, ACCELERATION * delta)
	velocity.x = move_toward(velocity.x, input.x * MAX_SPEED, ACCELERATION * delta)
	move_and_slide()

func _get_input():
	input = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')

############################################################
func _on_hurtbox_hurt(_hitbox, dmg):
	if invulnerable:
		return
	else:
		Utils.player.hp -= dmg
		Utils.change_hp.emit()
		hit_animation_player.play("hit")
		Utils.screen_shake.emit(6.0, 0.3)

###########################
func _set_invulnerable(new_state : bool):
	invulnerable = new_state


