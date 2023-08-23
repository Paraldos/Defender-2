extends CanvasLayer

@onready var health_top_bar = %HealthTopBar
@onready var health_bottom_bar = %HealthBottomBar
@onready var credits_label = %CreditsLabel

############################################################
func _ready():
	Utils.change_hp.connect(_on_change_hp)

############################################################
func _physics_process(_delta):
	credits_label.text = 'Credits: %s' % Utils.player.credits

############################################################
func _on_change_hp():
	health_top_bar.max_value = Utils.player.max_hp
	health_bottom_bar.max_value = Utils.player.max_hp
	###
	if Utils.player.hp < health_bottom_bar.value:
		_animate_health_bar(health_bottom_bar, health_top_bar)
	else:
		_animate_health_bar(health_top_bar, health_bottom_bar)

###########################
func _animate_health_bar(primary_bar, secondary_bar):
	primary_bar.value = Utils.player.hp
	var tween = get_tree().create_tween()
	tween.tween_property(
		secondary_bar,
		'value',
		Utils.player.hp,
		0.5
	)
