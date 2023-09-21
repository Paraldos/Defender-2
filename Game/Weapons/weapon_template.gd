extends Node2D

@export var projectile_speed = 300
@export var dmg = 5
@export_enum('player', 'enemy') var target = 'player'
@onready var ray_cast_to_target = %RayCastToTarget

##############################################################################
func _ready():
	pass

##############################################################################
func _process(delta):
	pass

##############################################################################
# overwrite
func _attack():
	pass

#################################
func _spawn_projectile(projectile):
	var new_projectile = projectile.instantiate()
	new_projectile.global_position = global_position
	new_projectile.movement = global_position.direction_to(
		to_global(ray_cast_to_target.target_position)) * projectile_speed
	new_projectile.dmg = dmg
	new_projectile.target = target
	get_tree().current_scene.add_child(new_projectile)
