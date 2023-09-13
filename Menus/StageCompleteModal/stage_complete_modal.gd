extends "res://Menus/modal_template.gd"

@onready var btn_shop = %BtnShop
@onready var btn_next = %BtnNext
var shop_modal = preload('res://Menus/ShopModal/shop_modal.tscn')

###############################################################################
func _ready():
	btn_next.grab_focus()

###############################################################################
func _on_btn_next_pressed():
	animation_player.play("move_out")
	Utils._next_satage()
	await _panel_wait()
	SceneTransition._change_scene("res://Game/World/world.tscn")

###############################################################################
func _on_btn_shop_pressed():
	var new = shop_modal.instantiate()
	get_tree().current_scene.add_child(new)
	###
	animation_player.play("move_out")

