extends "res://Game/Enemies/enemy_template.gd"

@onready var muzzle = %Muzzle
@onready var audio_stream_player_gun = $AudioStreamPlayerGun
@export var speed = Vector2(-200, 0)
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
		audio_stream_player_gun.play()
		var x_speed = -250
		var y_speed = 75
		_spawn_projectile(Vector2(x_speed, y_speed))
		_spawn_projectile(Vector2(x_speed, -y_speed))
		await get_tree().create_timer(0.4).timeout

#########################
func _spawn_projectile(movement):
	var new = projectile.instantiate()
	new.dmg = dmg
	new.global_position = muzzle.global_position
	new.movement = movement
	get_tree().current_scene.add_child(new)
