extends CharacterBody2D

const ACCELERATION = 3000.0
const MAX_SPEED = 400.0
var input = Vector2.ZERO
@export var invulnerable = false
@export var controlls_enabled = false
@onready var hit_animation_player = %HitAnimationPlayer
@onready var warp_controller = %WarpController
@onready var main_sprite = %MainSprite
@onready var death_controller = %DeathController
@onready var laser = $Laser

##############################################################################
func _ready():
	controlls_enabled = false
	Utils.boss_dying.connect(_on_boss_dying)
	Utils.boss_dead.connect(_on_boss_dead)
	await get_tree().create_timer(0.1).timeout
	Utils.player.node = self
	Utils.change_hp.emit()
	Utils.change_ep.emit()

#################################
func _on_boss_dying():
	invulnerable = true
	controlls_enabled = false
	main_sprite._move_animation(0)
	await create_tween().tween_property(
		self, 
		'global_position', 
		Vector2(160, 135), 
		3.0).finished

func _on_boss_dead():
	await get_tree().create_timer(1.0).timeout
	warp_controller._start_warp_out()

##############################################################################
func _physics_process(delta):
	Utils.player.position = global_position
	if controlls_enabled:
		_get_input()
		_movement(delta)
		main_sprite._move_animation(input.y)
	_meaga_laser()

func _movement(delta):
	velocity.y = move_toward(velocity.y, input.y * MAX_SPEED, ACCELERATION * delta)
	velocity.x = move_toward(velocity.x, input.x * MAX_SPEED, ACCELERATION * delta)
	move_and_slide()

func _get_input():
	input = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')

##############################################################################
var laser_cost = 10

func _meaga_laser():
	if Utils.player.laser <= 0: return
	if invulnerable: return
	if !controlls_enabled: return
	if Input.is_action_just_pressed('ui_mega_laser'):
		if Utils.player.ep >= laser_cost:
			_pay_energy()
			laser._attack()

func _pay_energy():
	Utils.player.ep -= laser_cost
	Utils.change_ep.emit()

##############################################################################
func _on_hurtbox_hurt(_hitbox, dmg):
	if invulnerable:
		return
	else:
		Utils.player.hp -= dmg
		Utils.change_hp.emit()
		Utils.screen_shake.emit(6.0, 0.3)
		hit_animation_player.play("hit")
		invulnerable = true
		await hit_animation_player.animation_finished
		invulnerable = false
	if Utils.player.hp <= 0:
		invulnerable = true
		controlls_enabled = false
		death_controller._death()

##############################################################################
