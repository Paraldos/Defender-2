extends Node2D

@onready var main_gun_double = $MainGunDouble
@onready var timer = $Timer

func _physics_process(delta):
	if get_parent().controlls_enabled:
		if Input.is_action_pressed('ui_attack') && timer.is_stopped():
			main_gun_double._attack()
			timer.start()
