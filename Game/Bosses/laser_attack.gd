extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var hitbox = $Hitbox
@export var dmg = 5
@export var active = false

##############################################################################
func _ready():
	active = false

func _physics_process(delta):
	_dmg()

##############################################################################
func _attack():
	animation_player.play("Attack")

func _dmg():
	if !active: return
	for hurtbox in hitbox.get_overlapping_areas():
		if not hurtbox is Hurtbox: return
		hurtbox._take_hit(self, dmg)
