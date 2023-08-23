extends "res://Game/Enemies/enemy_template.gd"

@onready var muzzle = %Muzzle
@onready var muzzle_animation_player = %MuzzleAnimationPlayer
@export var speed = Vector2(-150, 0)
var projectile = preload("res://Game/Projectile/gunship_projectile.tscn")

###############################################################################
func _process(delta):
	super._process(delta)
	_move(delta)

#########################
func _move(delta):
	global_position += speed * delta

###############################################################################
func _on_attack_timer_timeout():
	for i in 3:
		var x_speed = -250
		var y_speed = 75
		_spawn_projectile(Vector2(x_speed, y_speed))
		_spawn_projectile(Vector2(x_speed, -y_speed))
		await get_tree().create_timer(0.4).timeout

#########################
func _spawn_projectile(movement):
	_muzzle_flash_animation()
	var new = projectile.instantiate()
	new.global_position = muzzle.global_position
	new.movement = movement
	get_tree().current_scene.add_child(new)

func _muzzle_flash_animation():
	muzzle_animation_player.play("flash")
	var offset = 3.0
	muzzle.offset = Vector2(
		rng.randf_range(-offset, offset),
		rng.randf_range(-offset, offset)
	)
