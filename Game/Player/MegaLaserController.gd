extends Node2D

@onready var hitbox = $Hitbox
@export var laser_time = 1.0
@export var activation_cost = 10
@export var base_dmg = 9
@onready var audio_stream_player = $AudioStreamPlayer
var dmg = base_dmg + Utils.player.laser
var active = false

##############################################################################
func _ready():
	visible = false

##############################################################################
func _physics_process(delta):
	return
	_active()
	if Utils.player.laser <= 0: return
	if get_parent().invulnerable: return
	if !get_parent().controlls_enabled: return
	if Input.is_action_just_pressed('ui_mega_laser'):
		if Utils.player.ep >= activation_cost:
			_pay_energy()
			_enable_mega_laser()
			_disable_laser()

func _active():
	if active:
		_deal_dmg(hitbox.get_overlapping_areas())

func _pay_energy():
	Utils.player.ep -= activation_cost
	Utils.change_ep.emit()

func _enable_mega_laser():
	audio_stream_player.play()
	visible = true
	active = true
	_deal_dmg(hitbox.get_overlapping_areas())

func _disable_laser():
	await get_tree().create_timer(laser_time).timeout
	visible = false
	active = false

func _deal_dmg(overlapping_areas):
	if !active: return
	for area in overlapping_areas:
		if not area is Hurtbox: return
		area._take_hit(self, dmg)
