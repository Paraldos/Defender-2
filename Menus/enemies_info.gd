extends HBoxContainer
@onready var value = %Value
@export var total = false

func _ready():
	if total:
		value.text = "%s / %s" % [Utils.total.enemies_killed, Utils.total.enemies_spawned]
	else:
		value.text = "%s / %s" % [Utils.stage.enemies_killed, Utils.stage.enemies_spawned]

