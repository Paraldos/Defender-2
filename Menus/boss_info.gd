extends HBoxContainer
@onready var value = $Value

func _ready():
	value.text = "%s / %s" % [Utils.bosses.killed, Utils.bosses.total]
