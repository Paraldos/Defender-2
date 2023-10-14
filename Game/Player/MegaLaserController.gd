extends Node2D

@onready var laser = $Laser
var laser_cost = 10

##############################################################################
func _ready():
	laser.dmg = 2 + Utils.player.laser

##############################################################################
func _physics_process(_delta):
	if Utils.player.laser <= 0: return
	if get_parent().invulnerable: return
	if !get_parent().controlls_enabled: return
	if Input.is_action_just_pressed('ui_mega_laser'):
		if Utils.player.ep >= laser_cost:
			_pay_energy()
			laser._attack(1.0)

func _pay_energy():
	Utils.player.ep -= laser_cost
	Utils.change_ep.emit()
