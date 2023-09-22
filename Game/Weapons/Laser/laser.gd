extends Node2D

@onready var animation_player_attack = $AnimationPlayerAttack

@export var active = false
@export var charge = false

##############################################################################
func _ready():
	visible = false

##############################################################################
func _attack():
	animation_player_attack.play("attack")
