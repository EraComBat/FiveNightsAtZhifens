extends Node2D
func _ready():
	Global.gift_ai = 1
	print($".".get_child_count(true))
	Global.zhifen_ai=0
	Global.mw_ai=0
	Global.bot_ai=0
	Global.ghost_ai=0
	Global.evil_ai=0
	Global.warden_ai=0
	pass
	

	
func _process(delta):

	if Input.is_action_pressed('quit'):
		Global.currentnight = 6
		get_tree().change_scene_to_file('res://scenes/menu.tscn')
	$"1".text = str(Global.zhifen_ai)
	$"2".text = str(Global.mw_ai)
	$"3".text = str(Global.bot_ai)
	$"4".text = str(Global.ghost_ai)
	$"5".text = str(Global.evil_ai)
	$"6".text = str(Global.warden_ai)
	$"9".text = str(Global.gift_ai)
	
	if Global.zhifen_ai > 20:
		Global.zhifen_ai = 0
	if Global.zhifen_ai < 0:
		Global.zhifen_ai = 20
		
	if Global.mw_ai > 20:
		Global.mw_ai = 0
	if Global.mw_ai < 0:
		Global.mw_ai = 20
		
	if Global.bot_ai > 20:
		Global.bot_ai = 0
	if Global.bot_ai < 0:
		Global.bot_ai = 20
		
	if Global.ghost_ai > 20:
		Global.ghost_ai = 0
	if Global.ghost_ai < 0:
		Global.ghost_ai = 20
		
	if Global.evil_ai > 20:
		Global.evil_ai = 0
	if Global.evil_ai < 0:
		Global.evil_ai = 20
		
	if Global.warden_ai > 20:
		Global.warden_ai = 0
	if Global.warden_ai < 0:
		Global.warden_ai = 20


func _on_plus_pressed():
	if Global.zhifen_ai == 20:
		Global.zhifen_ai = 0
	else:
		Global.zhifen_ai += 1
	
	pass # Replace with function body.


func _on_plus_2_pressed():
	if Global.mw_ai == 20:
		Global.mw_ai = 0
	else:
		Global.mw_ai += 1
	pass # Replace with function body.


func _on_plus_3_pressed():
	if Global.bot_ai == 20:
		Global.bot_ai = 0
	else:
		Global.bot_ai += 1
	pass # Replace with function body.


func _on_plus_4_pressed():
	if Global.ghost_ai == 20:
		Global.ghost_ai = 0
	else:
		Global.ghost_ai += 1
	pass # Replace with function body.


func _on_plus_5_pressed():
	if Global.evil_ai == 20:
		Global.evil_ai = 0
	else:
		Global.evil_ai += 1
	pass # Replace with function body.


func _on_plus_6_pressed():
	if Global.warden_ai == 20:
		Global.warden_ai = 0
	else:
		Global.warden_ai += 1
	pass # Replace with function body.


func _on_minus_pressed():
	if Global.zhifen_ai == 0:
		Global.zhifen_ai = 20
	else:
		Global.zhifen_ai -= 1
	pass # Replace with function body.


func _on_minus_2_pressed():
	if Global.mw_ai == 0:
		Global.mw_ai = 20
	else:
		Global.mw_ai -= 1
	pass # Replace with function body.


func _on_minus_3_pressed():
	if Global.bot_ai == 0:
		Global.bot_ai = 20
	else:
		Global.bot_ai -= 1
	pass # Replace with function body.


func _on_minus_4_pressed():
	if Global.ghost_ai == 0:
		Global.ghost_ai = 20
	else:
		Global.ghost_ai -= 1
	pass # Replace with function body.


func _on_minus_5_pressed():
	if Global.evil_ai == 0:
		Global.evil_ai = 20
	else:
		Global.evil_ai -= 1
	pass # Replace with function body.


func _on_minus_6_pressed():
	if Global.warden_ai == 0:
		Global.warden_ai = 20
	else:
		Global.warden_ai -= 1
	pass # Replace with function body.


func _on_button_pressed():
	Global.currentnight = 7
	get_tree().change_scene_to_file("res://scenes/LoadScene.tscn")
	pass # Replace with function body.


func _on_minus_8_pressed():
	if Global.gift_ai == 1:
		Global.gift_ai = 6
	else:
		Global.gift_ai -= 0.25
	pass # Replace with function body.


func _on_plus_8_pressed():
	if Global.gift_ai == 6:
		Global.gift_ai = 1
	else:
		Global.gift_ai += 0.25
	pass # Replace with function body.
