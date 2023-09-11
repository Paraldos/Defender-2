extends HBoxContainer
@onready var value = %Value
@export var total = false

func _ready():
	if total:
		value.text = "%s / %s" % [Utils.enemies.total_killed, Utils.enemies.total]
	else:
		value.text = "%s / %s" % [Utils.enemies.stage_killed, Utils.enemies.stage]

