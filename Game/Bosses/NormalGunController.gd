extends Node2D

var projectile = preload('res://Game/Projectile/enemy_projectile.tscn')
@onready var muzzle = $Muzzle
@onready var animation_player = $AnimationPlayer

func _attack():
	for i in 6:
		animation_player.play("Attack")
		await get_tree().create_timer(0.2).timeout
	return true

func _spawn_projectile():
	var new = projectile.instantiate()
	new.global_position = muzzle.global_position
	get_tree().current_scene.add_child(new)
