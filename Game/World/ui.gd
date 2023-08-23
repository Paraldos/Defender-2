extends CanvasLayer

@onready var health_top_bar = %HealthTopBar
@onready var health_bottom_bar = %HealthBottomBar
@onready var credits_label = %CreditsLabel
@onready var energy_bottom_bar = %EnergyBottomBar
@onready var energy_top_bar = %EnergyTopBar

############################################################
func _ready():
	Utils.change_hp.connect(_on_change_hp)
	Utils.change_ep.connect(_on_change_ep)

############################################################
func _physics_process(_delta):
	credits_label.text = '%s' % Utils.player.credits

############################################################
func _on_change_hp():
	health_top_bar.max_value = Utils.player.max_hp
	health_bottom_bar.max_value = Utils.player.max_hp
	###
	if Utils.player.hp < health_bottom_bar.value:
		_animate_bar(health_bottom_bar, health_top_bar, Utils.player.hp)
	else:
		_animate_bar(health_top_bar, health_bottom_bar, Utils.player.hp)

func _on_change_ep():
	energy_top_bar.max_value = Utils.player.max_ep
	energy_bottom_bar.max_value = Utils.player.max_ep
	###
	if Utils.player.ep < energy_bottom_bar.value:
		_animate_bar(energy_bottom_bar, energy_top_bar, Utils.player.ep)
	else:
		_animate_bar(energy_top_bar, energy_bottom_bar, Utils.player.ep)

###########################
func _animate_bar(primary_bar, secondary_bar, target_value):
	primary_bar.value = target_value
	var tween = get_tree().create_tween()
	print(secondary_bar)
	tween.tween_property(
		secondary_bar,
		'value',
		target_value,
		0.5
	)
