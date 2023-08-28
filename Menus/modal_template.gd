extends CanvasLayer

var target_position = Vector2.ZERO
@onready var enemies_value = %EnemiesValue
@onready var credits_value = %CreditsValue

func _ready():
	enemies_value.text = "%s / %s" % [Utils.stage.enemies_killed, Utils.stage.enemies_total]
	credits_value.text = "%s" % Utils.player.credits

func _process(delta):
	pass
