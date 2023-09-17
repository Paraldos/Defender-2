extends "res://Game/Enemies/enemy_template.gd"

@export var speed_x = -175
@export var speed_y = 80
@onready var muzzle = %Muzzle
@onready var attack_animation_player = %AttackAnimationPlayer
@onready var attack_timer = %AttackTimer

var speed = Vector2(speed_x, speed_y)
var changing_direction = false
var projectile = preload("res://Game/Projectile/enemy_projectile.tscn")

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
		attack_animation_player.play("attack")
		_attack()
		await get_tree().create_timer(0.2).timeout

func _attack():
	var offset = 6
	var offset_y = rng.randi_range(-offset, offset)
	var new = projectile.instantiate()
	new.dmg = dmg
	new.global_position = muzzle.global_position + Vector2(0, offset_y)
	new.movement = Vector2(-400, 0)
	get_tree().current_scene.add_child(new)
