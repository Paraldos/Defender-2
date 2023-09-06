extends Node2D

var modulate_colors = [
	Color('80deea00'),
	Color('80deea')
]
var shield_time = 3 + Utils.player.shield
@onready var animation_player = $AnimationPlayer
@export var activation_cost = 10
@onready var audio_stream_player = $AudioStreamPlayer

##############################################################################
func _physics_process(_delta):
	if get_parent().invulnerable: return
	if !get_parent().controlls_enabled: return
	if Input.is_action_just_pressed('ui_mega_shield'):
		if Utils.player.ep >= activation_cost:
			Utils.player.ep -= activation_cost
			Utils.change_ep.emit()
			_enable_mega_shield()

##############################################################################
func _enable_mega_shield():
	audio_stream_player.play()
	get_parent().invulnerable = true
	animation_player.play("start")
	await animation_player.animation_finished
	await get_tree().create_timer(shield_time).timeout
	for i in 3:
		animation_player.play("blink")
		await animation_player.animation_finished
	animation_player.play("stop")
	await animation_player.animation_finished
	get_parent().invulnerable = false
