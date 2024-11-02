extends Label
@onready var audio_6am = $"../Node2D/6am"
var played :bool = false

func finish_anim_play():
	if played == false:
		if Global.currentTime == 6:
			
			$"../Node2D/fansound".stop()
			$"../Node2D/bgm".stop()
			audio_6am.play()
			$"../Black".visible = true
			$"../time6am".visible = true
			$"../Black2".play('black')
			await $"../Black2".animation_finished
			$"../time6am/points".play()
			$"../time6am/5to6".play()
			$"../time6am/5to0".play()
			$"../time6am/9to0".play()
			await get_tree().create_timer(13).timeout
			if Global.zhifen_ai == 20 && Global.bot_ai == 20 && Global.mw_ai == 20 && Global.ghost_ai == 20 && Global.evil_ai == 20 && Global.warden_ai == 20 && Global.currentnight == 7:
				Global.is_all20_beat = true
				Global.SaveGame()
			if Global.currentnight == 6:
				Global.is_night5_beat = true
				Global.SaveGame()
				get_tree().change_scene_to_file("res://scenes/menu.tscn")
			elif Global.currentnight == 7:
				Global.LoadGame()
				Global.is_night6_beat = true
				Global.SaveGame()
				get_tree().change_scene_to_file("res://scenes/menu.tscn")
			else:
				Global.currentnight += 1
				Global.SaveGame()
				get_tree().change_scene_to_file("res://scenes/LoadScene.tscn")
	pass
func _process(delta):
	$".".text = str(Global.currentTime) + ' AM'
	if Global.currentTime == 0:
		$".".text = '12 AM'
	if Global.currentTime > 6:
		$"../Timer_1min".start()
	if Global.currentTime == 5:
		$"../Timer_1min".one_shot = true
	if Global.currentTime == 6:
		finish_anim_play()
		played = true

	pass 
func _on_timer_timeout():
	Global.currentTime +=1
	if Global.currentTime == 6:
		
		$"../Node2D/fansound".stop()
		$"../Node2D/bgm".stop()
		audio_6am.play()
		$"../Black".visible = true
		$"../time6am".visible = true
		$"../Black2".play('black')
		await $"../Black2".animation_finished
		$"../time6am/points".play()
		$"../time6am/5to6".play()
		$"../time6am/5to0".play()
		$"../time6am/9to0".play()
		await get_tree().create_timer(7).timeout
		if Global.zhifen_ai == 20 && Global.bot_ai == 20 && Global.mw_ai == 20 && Global.ghost_ai == 20 && Global.evil_ai == 20 && Global.warden_ai == 20 && Global.currentnight == 7:
			Global.currentnight == 6
			Global.is_all20_beat = true
			Global.SaveGame()
		if Global.currentnight == 5:
			Global.is_night5_beat = true
			Global.SaveGame()
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
		if Global.currentnight == 6:
			Global.is_night6_beat = true
			Global.SaveGame()
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
		if Global.currentnight == 7:
			Global.currentnight == 6
			Global.SaveGame()
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
		elif Global.currentnight != 5 && Global.currentnight != 6 && Global.currentnight != 7 :
			Global.currentnight += 1
			Global.SaveGame()
			get_tree().change_scene_to_file("res://scenes/LoadScene.tscn")
		
	pass # Replace with function body.
