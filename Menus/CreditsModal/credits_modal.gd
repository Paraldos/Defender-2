extends "res://Menus/modal_template.gd"

@onready var btn_back = %BtnBack

func _ready():
	super._ready()
	btn_back.grab_focus()

func _on_btn_back_pressed():
	Utils.back_to_start.emit('credits')
	_move_out()
