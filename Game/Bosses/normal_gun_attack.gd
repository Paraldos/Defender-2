extends RayCast2D

var projectile = preload('res://Game/Projectile/enemy_projectile.tscn')
@export var projectile_speed = 300
@export var spray_margin = 0.0
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _attack():
	animation_player.play("Attack")
	audio_stream_player.pitch_scale = randf_range(0.8, 1.2)
	audio_stream_player.play()

func _spawn_projectile():
	var new = projectile.instantiate()
	var target_pos = to_global(target_position) + _get_spray()
	new.global_position = global_position
	new.movement = global_position.direction_to(target_pos) * projectile_speed
	get_tree().current_scene.add_child(new)

func _get_spray():
	var spray_x = rng.randf_range(-spray_margin, spray_margin)
	var spray_y = rng.randf_range(-spray_margin, spray_margin)
	return Vector2(spray_x, spray_y)
