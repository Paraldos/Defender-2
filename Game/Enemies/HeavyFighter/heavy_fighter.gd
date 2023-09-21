extends "res://Game/Enemies/enemy_template.gd"

@export var speed_x = -175
@export var speed_y = 80

@onready var attack_timer = %AttackTimer
@onready var bubble_gun = $BubbleGun

var speed = Vector2(speed_x, speed_y)
var changing_direction = false

###############################################################################
func _ready():
	if global_position.y > 0:
		speed.y *= -1

###############################################################################
func _process(delta):
	super._process(delta)
	_move(delta)

#########################
func _move(delta):
	position += speed * delta

###############################################################################
func _on_attack_timer_timeout():
	attack_timer.start(rng.randf_range(0.6, 0.8))
	for i in 2:
		bubble_gun._attack()
		await get_tree().create_timer(0.2).timeout
