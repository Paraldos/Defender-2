extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var panel = $Panel
@onready var panel_onscreen_position = panel.global_position
@onready var panel_offscreen_left = Vector2(-480, panel_onscreen_position.y)
@onready var panel_offscreen_right = Vector2(480, panel_onscreen_position.y)
var panel_time = 0.3

###############################################################################
func _ready():
	Utils.modals.append(self)

func _move_in():
	animation_player.play("move_in")

func _move_out():
	animation_player.play("move_out")

func _move_panel_in():
	_move_panel(panel_offscreen_right, panel_onscreen_position)

func _move_panel_out():
	_move_panel(panel_onscreen_position, panel_offscreen_left)

func _panel_wait():
	await get_tree().create_timer(panel_time - 0.05).timeout
	return true

func _move_panel(start_position, target_position):
	panel.global_position = start_position
	create_tween().tween_property(
		panel,
		'global_position',
		target_position,
		panel_time
	)

func _on_tree_exiting():
	var position = Utils.modals.find(self)
	if position >= 0:
		Utils.modals.remove_at(position)
