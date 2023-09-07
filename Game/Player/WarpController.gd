extends Node2D

@export var spawn_afterimage = false
@onready var warp_animation_player = %WarpAnimationPlayer
@onready var main_sprite = %MainSprite
@onready var player = $".."
var stage_complete_modal = preload('res://Menus/StageCompleteModal/stage_complete_modal.tscn')
var afterimage = preload("res://Game/Player/player_afterimage.tscn")
var warp_jump_effect = preload('res://Game/SFX/warp_jump_effect.tscn')
var afterimage_timer = 0

############################################################
func _ready():
	Utils.scene_transition_done.connect(_on_scene_transition_done)

###########################
func _on_scene_transition_done():
	_start_warp_in()

############################################################
func _start_warp_in():
	warp_animation_player.play("warp_in")

############################################################
func _start_warp_out():
	warp_animation_player.play("warp_out")

############################################################
func _warp_out_done():
	var new = stage_complete_modal.instantiate()
	get_tree().current_scene.add_child(new)
	get_parent().queue_free()

func _spawn_warp_jump_effect():
	var new = warp_jump_effect.instantiate()
	new.global_position = player.global_position
	get_tree().current_scene.add_child(new)

############################################################
func _physics_process(delta):
	afterimage_timer += delta
	if spawn_afterimage and afterimage_timer > 0.03:
		afterimage_timer = 0
		_spawn_afterimage()

###########################
func _spawn_afterimage():
	var new = afterimage.instantiate()
	new.global_position = main_sprite.global_position
	new.scale = main_sprite.scale
	get_tree().current_scene.add_child(new)
