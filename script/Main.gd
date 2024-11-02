extends Node2D
@onready var audio = $stuff/AudioStreamPlayer2D
@onready var bgm = $bgmPlayer
@onready var one = $stuff/star1/one
@onready var two = $stuff/star2/two
@onready var three = $stuff/star3/three
var firstentered :bool


func _ready():
	Global.LoadGame()
	if Global.currentnight == 6:
		$stuff/buttons/Button_continue.text = '继续 第6夜(奖励关)'
	$stuff/version.text = 'v '+Global.version + '  ' + Global.mode
	
	if Global.currentnight == 7:
		Global.currentnight == 6
		
	if Global.currentnight != 0 and Global.currentnight != 7:
		$stuff/buttons/Button_continue.text = '继续 第'+str(Global.currentnight)+'夜'
	if Global.currentnight == 6:
		$stuff/buttons/Button_continue.text = '继续 第6夜(奖励关)'
	if Global.currentnight == 0:
		$stuff/buttons/Button_continue.modulate = 'b8b8b8'
		$stuff/buttons/Button_continue.text = '继续'
	if Global.is_night5_beat:
		$stuff/star1.visible = true
	else:
		$stuff/buttons/Button_customnight.modulate = 'b8b8b8'
	if Global.is_night6_beat:
		$stuff/star2.visible = true
	if Global.is_all20_beat:
		$stuff/star3.visible = true
	$ParallaxBackground/ParallaxLayer/BG_bakery.visible = true
	bgm.play()
	pass


func _process(delta) :
	if Global.show_fps == true:
		$settings3.text = '显示fps:启用'
	else:
		$settings3.text = '显示fps:禁用'
		
	
	if Global.currentnight == 7:
		Global.currentnight = 6
	


#以下是每个按钮实现的功能


func _on_button_about_pressed():
	$stuff/buttons.visible = false
	
	$stuff/about.visible = true
	
	pass # Replace with function body.

func _on_button_pressed():
	$stuff/about.visible = false
	$stuff/buttons.visible = true
	pass # Replace with function body.


func _on_button_continue_pressed():
	
	if Global.currentnight != 0:
		audio.play()
		$AnimatedSprite2D2.visible = true
		$AnimatedSprite2D2.play()
		await $AnimatedSprite2D2.animation_finished
		get_tree().change_scene_to_file("res://scenes/LoadScene.tscn")
	else:
		return
	pass # Replace with function body.
func _on_button_customnight_pressed():
	if Global.is_night5_beat:
	
		get_tree().change_scene_to_file("res://scenes/custom.tscn")
	pass # Replace with function body.



func _on_button_quit_button_down():
	get_tree().quit()
	pass # Replace with function body.

func _on_button_newgame_pressed():
	Global.newgame = true
	Global.currentnight = 1
	audio.play()
	$AnimatedSprite2D2.visible = true
	$AnimatedSprite2D2.play()
	await $AnimatedSprite2D2.animation_finished
	get_tree().change_scene_to_file("res://scenes/LoadScene.tscn")




#以下是每个按钮鼠标进入/退出的效果

func _on_button_quit_mouse_entered():
	$stuff/buttons/Button_quit.text = '>>退出'
	audio.play()
	pass # Replace with function body.


func _on_button_quit_mouse_exited():
	$stuff/buttons/Button_quit.text = '退出'
	pass # Replace with function body.



func _on_button_newgame_mouse_entered():
	$stuff/buttons/Button_newgame.text = '>>新游戏'
	audio.play()
	pass # Replace with function body.


func _on_button_newgame_mouse_exited():
	$stuff/buttons/Button_newgame.text = '新游戏'
	
	pass # Replace with function body.


func _on_button_continue_mouse_entered():
	if Global.currentnight !=0:
		$stuff/buttons/Button_continue.text = '>>继续 第'+str(Global.currentnight)+'夜'
	if Global.currentnight == 6:
		$stuff/buttons/Button_continue.text = '>>继续 第6夜(奖励关)'
	if Global.currentnight == 0:
		$stuff/buttons/Button_continue.modulate = 'b8b8b8'
		$stuff/buttons/Button_continue.text = '>>继续'
	audio.play()
	pass # Replace with function body.


func _on_button_continue_mouse_exited():
	if Global.currentnight !=0 and Global.currentnight != 7:
		$stuff/buttons/Button_continue.text = '继续 第'+str(Global.currentnight)+'夜'
	if Global.currentnight >5:
		$stuff/buttons/Button_continue.text = '继续 第'+str(Global.currentnight)+'夜(奖励关)'
	if Global.currentnight == 0:
		$stuff/buttons/Button_continue.modulate = 'b8b8b8'
		$stuff/buttons/Button_continue.text = '继续'
	pass # Replace with function body.


func _on_button_nightex_mouse_entered():
	$stuff/buttons/Button_nightex.text = '>>第6夜'
	audio.play()
	pass # Replace with function body.


func _on_button_nightex_mouse_exited():
	$stuff/buttons/Button_nightex.text = '第6夜'
	pass # Replace with function body.


func _on_button_about_mouse_entered():
	$stuff/buttons/Button_about.text = '>>关于'
	audio.play()
	pass # Replace with function body.


func _on_button_about_mouse_exited():
	$stuff/buttons/Button_about.text = '关于'
	pass # Replace with function body.


func _on_button_customnight_mouse_entered():
	$stuff/buttons/Button_customnight.text = '>>自定义夜'
	audio.play()
	pass # Replace with function body.


func _on_button_customnight_mouse_exited():
	$stuff/buttons/Button_customnight.text = '自定义夜'
	pass # Replace with function body.




func _on_bgm_player_finished():
	bgm.play()
	pass # Replace with function body.


func _on_settings_pressed():
	if $settings3.visible == false:
		$stuff/buttons.visible = false
		$stuff/delete.visible = true
		$settings3.visible = true
		$settings.text = '返回'
	
	elif $settings3.visible == true:
		$settings.text = '设置'
		$stuff/buttons.visible = true
		$stuff/delete.visible = false
		$settings3.visible = false
	pass # Replace with function body.


func _on_delete_pressed():
	$stuff/delete/Label.visible = true
	$stuff/buttons.visible = false
	$settings3.visible = false
	$settings.visible = false
	
	pass # Replace with function body.


func _on_yes_pressed():
	var file = FileAccess.open(Global.save_game_file,FileAccess.WRITE)
	var data : Dictionary = {
		'currentnight' : 0,
		'is_night5_beat' : false,
		'is_night6_beat' : false,
		'is_night7_beat' : false,
		'is_all20_beat' : false,
		'show_fps' : false
	}
	file.store_line(JSON.stringify(data))
	firstentered = true
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	$stuff/delete/Label.visible = false
	$stuff/buttons.visible = true
	pass # Replace with function body.


func _on_no_pressed():
	$stuff/delete/Label.visible = false
	$stuff/buttons.visible = true
	$settings3.visible = true
	$settings.visible = true
	pass # Replace with function body.

#1



func _on_yi_mouse_entered():
	one.visible = true
	pass # Replace with function body.


func _on_yi_mouse_exited():
	one.visible = false
	pass # Replace with function body.


func _on_er_mouse_entered():
	two.visible = true
	pass # Replace with function body.


func _on_er_mouse_exited():
	two.visible = false
	pass # Replace with function body.


func _on_san_mouse_entered():
	three.visible = true
	pass # Replace with function body.


func _on_san_mouse_exited():
	three.visible = false
	pass # Replace with function body.


	

func _on_settings_3_pressed():
	if Global.show_fps == true:
		Global.show_fps = false
	elif Global.show_fps == false:
		Global.show_fps = true
	Global.SaveGame()
	pass # Replace with function body.
