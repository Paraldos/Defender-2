extends RayCast2D

var projectile = preload('res://Game/Projectile/pulse_projectile.tscn')
@export var projectile_speed = 300
@onready var audio_stream_player = $AudioStreamPlayer
@onready var muzzle = $Muzzle
@onready var animation_player = $Muzzle/AnimationPlayer

func _attack():
	_spawn_projectile(muzzle.position.direction_to(target_position) * projectile_speed)
	animation_player.play("attack")
	audio_stream_player.play()

func _spawn_projectile(movemenet):
	var new = projectile.instantiate()
	new.global_position = global_position
	new.movement = movemenet
	get_tree().current_scene.add_child(new)
