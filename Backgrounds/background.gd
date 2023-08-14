extends CanvasLayer

##############################################################################
var background_textures = [
	preload("res://Assets/Img/Backgrounds/Space_01-Sheet.png"),
	preload("res://Assets/Img/Backgrounds/Space_02-Sheet.png"),
	preload("res://Assets/Img/Backgrounds/Space_03-Sheet.png"),
	preload("res://Assets/Img/Backgrounds/Space_04-Sheet.png")
]
@onready var parallax_background = %ParallaxBackground
@onready var sprites = [
	%Layer1Sprite,
	%Layer2Sprite,
	%Layer3Sprite,
	%Layer4Sprite,
	%Layer5Sprite
]
@export var speed = Vector2(0.0, 50.0)
var rng = RandomNumberGenerator.new()

##############################################################################
func _ready():
	rng.randomize()
	_get_randome_background()

#########################################
func _get_randome_background():
	var randome_background_number = rng.randi_range(0, background_textures.size() -1)
	for sprite in sprites:
		sprite.texture = background_textures[randome_background_number]

##############################################################################
func _physics_process(delta):
	_paralax_movemenet(delta)

#########################################
func _paralax_movemenet(delta):
	var layer_speed_difference = 1.0
	for paralax_layer in parallax_background.get_children():
		paralax_layer.motion_offset.y += speed.y * layer_speed_difference * delta
		paralax_layer.motion_offset.x += speed.x * layer_speed_difference * delta
		layer_speed_difference += 0.15


