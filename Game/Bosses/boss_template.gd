extends Node2D

@export var hp = 100
@export var invulnerable = true
@onready var hurtbox_animation_player = $Hurtbox/HurtboxAnimationPlayer
@onready var hurtbox = %Hurtbox
var rng = RandomNumberGenerator.new()
var mini_explosions = false
var mini_explosion_timer = 0
var state = 'start'
var waittime_between_actions = 0.3

###############################################################################
func _ready():
	Utils.stage.enemies_total += 1
	hurtbox.scale = Vector2(1.05, 1.05)
	rng.randomize()
	Utils.change_background_speed.emit(Vector2.ZERO)
	invulnerable = true
	global_position = Vector2(480+200, 270/2)
	_next_move()

###############################################################################
func _process(delta):
	_mini_explosions(delta)

func _mini_explosions(delta):
	if !mini_explosions: return
	mini_explosion_timer += delta
	if mini_explosion_timer >= 0.1:
		_spawn_mini_explosion()
		mini_explosion_timer = 0

func _spawn_mini_explosion():
	var max_offset = 30
	var target_position = global_position
	target_position.x += rng.randf_range(-max_offset, max_offset)
	target_position.y += rng.randf_range(-max_offset, max_offset)
	SfxController._spawn_explosion_01(target_position)

###############################################################################
func _next_move():
	if hp <= 0:
		state = 'death'
	match state:
		'start':
			await _start(Vector2(380, 135))
			state = 'move'
		'move':
			await get_tree().create_timer(waittime_between_actions).timeout
			await _move()
			state = 'attack'
		'attack':
			await get_tree().create_timer(waittime_between_actions).timeout
			await _attack()
			state = 'move'
		'death':
			_death()
			return false
	_next_move()

# overwrite if needed
func _start(target_position):
	await create_tween().tween_property(
		self, 
		'global_position', 
		target_position, 
		3).finished
	await get_tree().create_timer(1).timeout
	await get_tree().create_timer(1).timeout
	invulnerable = false
	return true

# overwrite
func _move(): return true

# overwrite
func _attack(): return true

# overwrite if needed
func _death():
	Utils.stage.enemies_killed += 1
	Utils.boss_dying.emit()
	mini_explosions = true
	await create_tween().tween_property(
		self,
		'global_position',
		Vector2(320, 135),
		3
	).set_ease(Tween.EASE_IN_OUT).finished
	await get_tree().create_timer(1).timeout
	SfxController._spawn_explosion_05(global_position)
	Utils.boss_dead.emit()
	Utils.change_background_speed.emit(Vector2(25, 0))
	queue_free()

###############################################################################
func _on_hurtbox_hurt(hitbox, dmg):
	if invulnerable: return
	hurtbox_animation_player.play("hit")
	hp -= dmg

###############################################################################
func _on_hitbox_area_entered(area):
	SfxController._spawn_explosion_02(area.global_position)
