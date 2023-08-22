extends CanvasLayer

@onready var health_top_bar = %HealthTopBar
@onready var health_bottom_bar = %HealthBottomBar

func _ready():
	Utils.change_hp.connect(_on_change_hp)

func _on_change_hp():
	health_top_bar.max_value = Utils.player.max_hp
	health_bottom_bar.max_value = Utils.player.max_hp
	###
	health_bottom_bar.value = Utils.player.hp
	var tween = get_tree().create_tween()
	tween.tween_property(
		health_top_bar,
		'value',
		Utils.player.hp,
		0.5
	)
