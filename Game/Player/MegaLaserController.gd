extends Node2D

@onready var laser_timer = $LaserTimer
@onready var hitbox = $Hitbox
@export var laser_time = 1.0
@export var activation_cost = 10
@export var base_dmg = 5
@onready var audio_stream_player = $AudioStreamPlayer
var dmg = base_dmg + Utils.player.laser
var active = false

##############################################################################
func _ready():
	visible = false

##############################################################################
func _physics_process(_delta):
	if get_parent().invulnerable: return
	if !get_parent().controlls_enabled: return
	if Input.is_action_just_pressed('ui_mega_laser'):
		if Utils.player.ep >= activation_cost:
			Utils.player.ep -= activation_cost
			Utils.change_ep.emit()
			_enable_mega_laser()

##############################################################################
func _enable_mega_laser():
	audio_stream_player.play()
	visible = true
	active = true
	_deal_dmg()
	laser_timer.start()
	await get_tree().create_timer(laser_time).timeout
	visible = false
	active = false

##############################################################################
func _on_laser_timer_timeout():
	_deal_dmg()

func _on_hitbox_area_entered(_area):
	_deal_dmg()

func _deal_dmg():
	if !active: return
	var hurtboxes = hitbox.get_overlapping_areas()
	for hurtbox in hurtboxes:
		if not hurtbox is Hurtbox: return
		hurtbox._take_hit(self, dmg)
