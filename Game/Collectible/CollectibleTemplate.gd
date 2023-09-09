extends Area2D

@export var initial_speed = 0
var movement = Vector2.ZERO
var target_movement = Vector2(-70, 0)
var rng = RandomNumberGenerator.new()
var move_to_player = false

##############################################################################
func _ready():
	rng.randomize()
	_get_start_movement()
	create_tween().tween_property(self, "movement", target_movement, 0.5)

##############################################################################
func _physics_process(delta):
	if move_to_player:
		_move_to_player()
	else :
		global_position += movement * delta

func _move_to_player():
	create_tween().tween_property(
		self, 
		'global_position', 
		Utils.player.position, 
		0.5
	)

##############################################################################
func _on_area_entered(_area):
	move_to_player = true

################################ HELPER
func _get_start_movement():
	movement = Vector2(
		rng.randf_range(-1, 1), 
		rng.randf_range(-1, 1)
	) * initial_speed
