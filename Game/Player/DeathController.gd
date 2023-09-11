extends Node2D

@onready var player_collision = $"../PlayerCollision"
@onready var hurtbox_collision = $"../Hurtbox/HurtboxCollision"
@onready var magnet_collision = $"../Magnet/MagnetCollision"
@onready var main_sprite = %MainSprite
@onready var death_sfx = $DeathSfx
var game_over_modal = preload('res://Menus/GameOverMenu/game_over_modal.tscn')
var wiggle = false
var rng = RandomNumberGenerator.new()
var max_offset = 4

###############################################################################
func _ready():
	rng.randomize()

##############################################################################
func _physics_process(delta):
	if wiggle:
		var offset_x = rng.randi_range(-max_offset, max_offset)
		var offset_y = rng.randi_range(-max_offset, max_offset)
		main_sprite.offset = Vector2(offset_x, offset_y)

##############################################################################
func _death():
	await _start_death()
	await _death_middle()
	_death_end()

func _start_death():
	Utils.player_death.emit()
	_disable_collision()
	_start_death_effects()
	await get_tree().create_timer(1.0).timeout
	return true

func _start_death_effects():
	wiggle = true
	death_sfx.play()

func _disable_collision():
	# player_collision.disabled = true
	hurtbox_collision.disabled = true
	magnet_collision.disabled = true

func _death_middle():
	SfxController._spawn_explosion_05(global_position)
	Utils.change_background_speed.emit(Vector2.ZERO)
	get_parent().visible = false
	await get_tree().create_timer(1.0).timeout
	return true

func _death_end():
	var new_modal = game_over_modal.instantiate()
	get_tree().current_scene.add_child(new_modal)
	await get_tree().create_timer(3.0).timeout
	get_parent().queue_free()
