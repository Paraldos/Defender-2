extends Camera2D

var shake_strength = 0.0
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	Utils.screen_shake.connect(_on_screen_shakee)

func _on_screen_shakee(strength : float, duration : float):
	if strength > shake_strength:
		shake_strength = strength
	var tween = get_tree().create_tween()
	tween.tween_property(
		self,
		'shake_strength',
		0.0,
		duration
	)

func _physics_process(delta):
	var offset_x = rng.randf_range(-shake_strength, shake_strength)
	var offset_y = rng.randf_range(-shake_strength, shake_strength)
	offset = Vector2(offset_x, offset_y)
