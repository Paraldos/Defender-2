extends Node2D

@onready var sprite_bomb = %SpriteBomb
@onready var animation_player = $SpriteExplosion/AnimationPlayer
@onready var hitbox = $SpriteExplosion/Hitbox
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _physics_process(_delta):
	_wiggle()

func _wiggle():
	var max_offset = 2
	var new_pos_x = rng.randi_range(-max_offset, max_offset)
	var new_pos_y = rng.randi_range(-max_offset, max_offset)
	sprite_bomb.position = Vector2(new_pos_x, new_pos_y)

func _explosion():
	animation_player.play("explosion")
