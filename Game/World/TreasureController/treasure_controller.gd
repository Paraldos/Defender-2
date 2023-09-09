extends Node2D

@onready var powerup_timer = $PowerupTimer
var rng = RandomNumberGenerator.new()
var credit = preload("res://Game/Collectible/credit.tscn")
var powerup = false
var powerups = [
	preload("res://Game/Collectible/hp_boost.tscn"),
	preload("res://Game/Collectible/ep_boost.tscn")
]

###############################################################################
func _ready():
	rng.randomize()
	Utils.spawn_treasure.connect(_on_spawn_treasure)

func _on_spawn_treasure(amount, position):
	for i in amount:
		_spawn_element(credit, position)
	if powerup:
		powerup = false
		powerup_timer.start()
		_spawn_element(powerups.pick_random(), position)

###############################################################################
func _on_powerup_timer_timeout():
	powerup = true

######################### HELPER
func _spawn_element(element, position):
	var new = element.instantiate()
	new.position = position
	get_tree().current_scene.add_child(new)
