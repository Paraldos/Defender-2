extends Node2D

var projectile = preload('res://Game/Projectile/enemy_projectile.tscn')
@onready var muzzle = $Muzzle
@onready var animation_player = $AnimationPlayer

func _attack():
	animation_player.play("Attack")

func _spawn_projectile():
	var new = projectile.instantiate()
	new.global_position = muzzle.global_position
	get_tree().current_scene.add_child(new)
