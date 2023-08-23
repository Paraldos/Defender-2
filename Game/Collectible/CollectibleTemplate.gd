extends Area2D

var movement = Vector2(50,50)
var base_movement = Vector2(-70, 0)
var move_to_player = false

############################################################
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "movement", base_movement, 0.5)

############################################################
func _physics_process(delta):
	if move_to_player:
		var tween = get_tree().create_tween()
		tween.tween_property(
			self, 
			'global_position', 
			Utils.player.position, 
			0.5
		)
	elif  movement != Vector2.ZERO:
		global_position += movement * delta

############################################################
func _on_area_entered(_area):
	move_to_player = true
