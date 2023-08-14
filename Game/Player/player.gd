extends CharacterBody2D

const ACCELERATION = 3000.0
const MAX_SPEED = 400.0
var input = Vector2.ZERO
@onready var main_sprite_animation_tree = $MainSprite/AnimationTree

############################################################
func _physics_process(delta):
	_movement(delta)

###########################
func _movement(delta):
	_get_input()
	velocity.y = move_toward(velocity.y, input.y * MAX_SPEED, ACCELERATION * delta)
	velocity.x = move_toward(velocity.x, input.x * MAX_SPEED, ACCELERATION * delta)
	_animation()
	move_and_slide()

func _animation():
	main_sprite_animation_tree.set('parameters/blend_position', input.y)

func _get_input():
	input = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
