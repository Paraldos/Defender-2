extends HBoxContainer
@onready var value = $Value

func _ready():
	value.text = "%s" % [Utils.total.bosses_killed]
