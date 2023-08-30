extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var panel = $Panel
@onready var panel_onscreen_position = panel.global_position
@onready var panel_offscreen_left = Vector2(-800, panel_onscreen_position.y)
@onready var panel_offscreen_right = Vector2(800, panel_onscreen_position.y)

###############################################################################
func _ready():
	pass

func _move_in():
	_move_panel(panel_offscreen_right, panel_onscreen_position)

func _move_out():
	_move_panel(panel_onscreen_position, panel_offscreen_left)

func _move_panel(start_position, target_position):
	panel.global_position = start_position
	create_tween().tween_property(
		panel,
		'global_position',
		target_position,
		0.8
	)
