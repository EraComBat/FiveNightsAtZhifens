extends Node2D
@onready var audio_buzzlight = $Node2D/buzzlight
@onready var audio_error = $Node2D/error
var now_audio_playing :bool
var rd_pressed :bool
var rm_pressed :bool
var ra_pressed :bool
var canhear_text = '可听见房间所播放音频'
var flashed:bool
var rooms = ['rooms/Cam0','rooms/Cam01','rooms/Cam02','rooms/Cam03','rooms/Cam04','rooms/Cam05','rooms/Cam06','rooms/Cam07','rooms/Cam08','rooms/Cam09','rooms/Cam10','rooms/Cam11']
var audio_sprites = [null,'maps/Bitmap/buttons/cam01/AnimatedSprite2D','maps/Bitmap/buttons/cam02/AnimatedSprite2D','maps/Bitmap/buttons/cam03/AnimatedSprite2D','maps/Bitmap/buttons/cam04/AnimatedSprite2D','maps/Bitmap/buttons/cam05/AnimatedSprite2D','maps/Bitmap/buttons/cam06/AnimatedSprite2D','maps/Bitmap/buttons/cam07/AnimatedSprite2D','maps/Bitmap/buttons/cam08/AnimatedSprite2D','maps/Bitmap/buttons/cam09/AnimatedSprite2D','maps/Bitmap/buttons/cam10/AnimatedSprite2D','maps/Bitmap/buttons/cam11/AnimatedSprite2D']
var presseds = [null,'maps/Bitmap/buttons/cam01/pressed','maps/Bitmap/buttons/cam02/pressed','maps/Bitmap/buttons/cam03/pressed','maps/Bitmap/buttons/cam04/pressed','maps/Bitmap/buttons/cam05/pressed','maps/Bitmap/buttons/cam06/pressed','maps/Bitmap/buttons/cam07/pressed','maps/Bitmap/buttons/cam08/pressed','maps/Bitmap/buttons/cam09/pressed','maps/Bitmap/buttons/cam10/pressed','maps/Bitmap/buttons/cam11/pressed']
var texts = [null,'cam01-大厅-大门','cam02-大厅-厨房入口','cam03-大厅-收银台','cam04-走廊a','cam05-配电室','cam06-厨房','cam07-左通风管','cam08-走廊b','cam09-库房','cam10-实验室','cam11-右通风管']



# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Global.show_fps == true:
		$debug/fps.visible = true
	else:
		$debug/fps.visible = false
	
	print($".".get_child_count(true))
	
	Global.jumpscared = false
	$"jumpscare mask".visible = false
	if Global.currentnight == 4:
		$timers/Timer_zhifen.start()
		$timers/Timer_mw.start()
		$timers/Timer_ghost.start()
		$timers/Timer_evil.start()
	if Global.currentnight == 5:
		$timers/Timer_zhifen.start()
		$timers/Timer_mw.start()
		$timers/Timer_ghost.start()
		$timers/Timer_evil.start()
		$timers/Timer_warden.start()
	
	
	randomize()
	Global.giftbread_spring = 20
	if Global.currentnight != 7:
		Global.zhifen_ai = Global.AILevel('zhifen',Global.currentnight)#1
		Global.mw_ai = Global.AILevel('mouthwash',Global.currentnight)#2
		Global.bot_ai =Global.AILevel('bot',Global.currentnight)#3
		Global.evil_ai =Global.AILevel('evilbread',Global.currentnight)#5
		Global.ghost_ai =Global.AILevel('ghostbread',Global.currentnight)#6
		Global.warden_ai =Global.AILevel('wardenbread',Global.currentnight)#7
		Global.shadow_ai =Global.AILevel('shadow',Global.currentnight)#8
	if Global.zhifen_ai != 0:
		Global.zhifen_currentroom = 03
	else:
		Global.zhifen_currentroom = 0
	if Global.evil_ai != 0:
		Global.evilbread_currentroom = 10
	else:
		Global.evilbread_currentroom = 0
	if Global.mw_ai != 0:
		Global.mouthwash_currentroom = 10
	else:
		Global.mouthwash_currentroom = 0
	if Global.ghost_ai != 0:
		Global.ghostbread_currentroom = 09
	else:
		Global.ghostbread_currentroom = 0
	if Global.warden_ai != 0:
		Global.wardenbread_currentroom = 01
	else:
		Global.wardenbread_currentroom = 0
		
	if Global.currentnight == 0:	
		$timers/Timer_gift.wait_time = 1.0
		
	if Global.currentnight == 1:
			$timers/Timer_gift.wait_time = 4.00
			

	elif Global.currentnight == 2:
		$timers/Timer_gift.wait_time = 3.75
		
	elif Global.currentnight == 3:
		$timers/Timer_gift.wait_time = 2.99
		
	elif Global.currentnight == 4:
		$timers/Timer_gift.wait_time = 2.25
		
	elif Global.currentnight == 5:
		$timers/Timer_gift.wait_time = 1.25
		
	elif Global.currentnight == 6:
		$timers/Timer_gift.wait_time = 0.85
		
	elif Global.currentnight == 7:
		$timers/Timer_gift.wait_time = Global.gift_ai
		
	Global.audio_durability = 5
	Global.currentTime = 0
	$TimerOfFlashlight.start()
	$TimerOfFlashlight.paused = true
	Global.flashlight_power = 5
	pass # Replace with function body.
	if not Global.currentnight == 0 and not Global.currentnight == 7 :
		get_node('Node2D/AudioStreamPlayer2D'+str(Global.currentnight)).play()
		$Node2D3.visible = true

	Global.audio_played_room = 0
	if Global.currentnight == 7:
		$timers/Timer_zhifen.start()
		$timers/Timer_mw.start()
		$timers/Timer_gift.start()
		$timers/Timer_evil.start()
		$timers/Timer_ghost.start()
		$timers/Timer_warden.start()
		
func _process(delta):
	
	
	
	
	if Global.currentTime == 6:
		Global.zhifen_currentroom = 0
		Global.mouthwash_currentroom = 0
		Global.evilbread_currentroom = 0
		Global.ghostbread_currentroom = 0
		Global.wardenbread_currentroom = 0
	if Global.currentnight == 7:
		$Node2D3.visible = false
	if Global.jumpscared == true:
		$"jumpscare mask".visible =true
		$mask.visible = false
		$fixpad.visible = false
		$pad.visible = false
		$Black.visible = false
		$rooms.visible = false
		$maps.visible = false
	if Global.monitor_broken == true:
		$rooms/blackofbreak.visible = true
	else:
		$rooms/blackofbreak.visible = false
	
	
	if Global.audio_played_room != 0:
		await get_tree().create_timer(0.5).timeout
		$rooms/static.visible = true
		$rooms/static.play()
		await get_tree().create_timer(0.1).timeout
		$rooms/static.visible = false
		$timers/Timer_warden.paused = true
		if Global.audio_played_room == 1 && Global.wardenbread_currentroom == 2 or Global.audio_played_room == 1 && Global.wardenbread_currentroom == 4:
			Global.wardenbread_currentroom = Global.audio_played_room
		elif Global.audio_played_room == 2 && Global.wardenbread_currentroom == 1 or Global.audio_played_room == 2 && Global.wardenbread_currentroom == 3 or Global.audio_played_room == 2 && Global.wardenbread_currentroom == 6:
			Global.wardenbread_currentroom = Global.audio_played_room
		elif Global.audio_played_room == 3 && Global.wardenbread_currentroom == 2 or Global.audio_played_room == 3 && Global.wardenbread_currentroom == 6:
			Global.wardenbread_currentroom = Global.audio_played_room
		elif Global.audio_played_room == 4 && Global.wardenbread_currentroom == 1 or Global.audio_played_room == 4 && Global.wardenbread_currentroom == 5 or Global.audio_played_room == 4 && Global.wardenbread_currentroom == 8:
			Global.wardenbread_currentroom = Global.audio_played_room
		elif Global.audio_played_room == 5 && Global.wardenbread_currentroom == 4 or Global.audio_played_room == 5 && Global.wardenbread_currentroom == 8:
			Global.wardenbread_currentroom = Global.audio_played_room
		elif Global.audio_played_room == 6 && Global.wardenbread_currentroom == 2 or Global.audio_played_room == 6 && Global.wardenbread_currentroom == 12:
			Global.wardenbread_currentroom = Global.audio_played_room
		elif Global.audio_played_room == 8 && Global.wardenbread_currentroom == 4 or Global.audio_played_room == 8 && Global.wardenbread_currentroom == 9 or Global.audio_played_room == 8 && Global.wardenbread_currentroom == 12:
			Global.wardenbread_currentroom = Global.audio_played_room
		elif Global.audio_played_room == 9 && Global.wardenbread_currentroom == 8 or Global.audio_played_room == 9 && Global.wardenbread_currentroom == 10:
			Global.wardenbread_currentroom = Global.audio_played_room
		elif Global.audio_played_room == 10 && Global.wardenbread_currentroom == 9 or Global.audio_played_room == 10 && Global.wardenbread_currentroom == 12:
			Global.wardenbread_currentroom = Global.audio_played_room
		
		else:
			$timers/Timer_warden.paused = false
		
		$timers/Timer_warden.paused = false
	
	
	
	
	if Global.giftbread_spring == 0 && Global.jumpscared == false && Global.currentTime != 6:
		
		if $maps/Bitmap/buttons/cam05/pressed/SPRING.visible == true:
			$maps/Bitmap/buttons/cam05/pressed/SPRING.visible == false
			$timers/Timer_gift/Timer111.start()
		
	$debug/fps.text = "FPS: " + str(Engine.get_frames_per_second())
	$debug/Label.text = '\n植粉当前房间:'+str(Global.zhifen_currentroom)+'    漱口水当前房间:'+str(Global.mouthwash_currentroom)+'\n邪恶面包当前房间:'+str(Global.evilbread_currentroom)+'    幽灵面包当前房间:'+str(Global.ghostbread_currentroom)+'\n幽灵面包被照次数:'+str(Global.ghostbread_flashed)+'    循声面包当前房间:'+str(Global.wardenbread_currentroom)+'    声音播放房间:'+str(Global.audio_played_room)+'\n植粉AI:'+str(Global.zhifen_ai)+'\n漱口水AI:'+str(Global.mw_ai)+'\nbotAI:'+str(Global.bot_ai)+'\n幽灵AI:'+str(Global.ghost_ai)+'\n邪恶AI:'+str(Global.evil_ai)+'\n循声AI:'+str(Global.warden_ai)
	if Global.ghostbread_flashed == 0:
		$bg/Ghost.modulate = 'ffffffff'
	elif Global.ghostbread_flashed == 1:
		$bg/Ghost.modulate = 'ffffffcf'
	elif Global.ghostbread_flashed == 2:
		$bg/Ghost.modulate = 'ffffffaa'
	elif Global.ghostbread_flashed == 3:
		$bg/Ghost.modulate = 'ffffff9c'
	elif Global.ghostbread_flashed == 4:
		$bg/Ghost.modulate = 'ffffff6e'
	elif Global.ghostbread_flashed == 5:
		$bg/Ghost.modulate = 'ffffff33'
	elif Global.ghostbread_flashed == 6:
		$bg/Ghost.modulate = 'ffffff0a'
		
	if Global.ghostbread_currentroom == 12 && Global.ghostbread_flashed == 6:
		Global.ghostbread_flashed = 0
		Global.ghostbread_currentroom = 9
		$timers/Timer_ghost.paused = false
	if Global.ghostbread_currentroom == 12:
		$bg/Ghost.visible = true
	else:
		$bg/Ghost.visible = false
	if Global.wardenbread_currentroom == 12:
		$bg/Warden.visible = true
	else:
		$bg/Warden.visible = false
	if Global.zhifen_currentroom == 12:
		$bg/zhifen.visible = true
	else:
		$bg/zhifen.visible = false
	#一大波visible正在靠近!
	for i in range(1,12):
		get_node(rooms[i]+'/zhifen').visible = false
	for i in range(1,12):
		get_node(rooms[i]+'/Mouthwash').visible = false
	for i in range(1,12):
		get_node(rooms[i]+'/Ghost').visible = false
	for i in range(1,12):
		get_node(rooms[i]+'/Evil').visible = false
	for i in range(1,12):
		get_node(rooms[i]+'/Warden').visible = false
	if Global.zhifen_currentroom < 12:
		get_node(rooms[Global.zhifen_currentroom]+'/zhifen').visible = true 
	if Global.mouthwash_currentroom < 12:
		get_node(rooms[Global.mouthwash_currentroom]+'/Mouthwash').visible = true
	if Global.ghostbread_currentroom < 12:
		get_node(rooms[Global.ghostbread_currentroom]+'/Ghost').visible = true
	if Global.evilbread_currentroom < 12:
		get_node(rooms[Global.evilbread_currentroom]+'/Evil').visible = true
	if Global.wardenbread_currentroom < 12:
		get_node(rooms[Global.wardenbread_currentroom]+'/Warden').visible = true
	if Global.giftbread_spring < 9 && Global.giftbread_spring > 5:
		$orawarn.visible = true
		$maps/Bitmap/orawarn.visible = true
	else:
		$orawarn.visible = false
		$maps/Bitmap/orawarn.visible = false
	if Global.giftbread_spring <= 5:
		$redwarn.visible = true
		$maps/Bitmap/redwarn.visible = true
	else:
		$redwarn.visible = false
		$maps/Bitmap/redwarn.visible = false

	if Global.current_room == 5:
		$maps/Bitmap/buttons/cam05/windup.visible = true
	else:
		$maps/Bitmap/buttons/cam05/windup.visible = false

	$maps/Bitmap/buttons/cam05/pressed/SPRING.frame = 20-Global.giftbread_spring
	if Global.giftbread_spring < 0:
		Global.giftbread_spring = -1
	if Global.current_room != 7 and now_audio_playing == false or Global.current_room != 11 and now_audio_playing == false:
		$maps/Bitmap/playaudio.visible = true
		$maps/Label2.visible = false
		$maps/Label3.visible = false
	if Global.current_room != 7 or Global.current_room != 11 :
		$maps/Label3.visible = false
	if Global.current_room == 7 or Global.current_room == 11:
		$maps/Bitmap/playaudio.visible = false
		$maps/Label2.visible = false
		$maps/Label3.visible = true
	$Label3.text='大门耐久:'+str(Global.door_durability)
	$Label4.text = '音频耐久:' +str(Global.audio_durability)
	if Global.door_durability >5:
		Global.door_durability = 5
	if Input.is_action_pressed('quit') && Global.currentTime != 6:
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
		#get_tree().change_scene_to_file('res://scenes/menu.tscn')
	
	
	if Global.flashlight_power > 0:
		if Input.is_action_just_pressed("flashlight") && Global.monitor_opened == false or Input.is_action_pressed("flashlight") && Global.monitor_opened == false:
			if flashed == false && Global.ghostbread_currentroom == 12:
				flashed = true
				Global.ghostbread_flashed += 1
			Global.flashlight_opened_office = true
			$TimerOfFlashlight.paused = false
			audio_buzzlight.play()
			$bg.visible = true
			$Flashlight.visible = true
			$ColorRect.visible = true
		if Input.is_action_just_released("flashlight") or Global.monitor_opened == true:
			flashed = false
			Global.flashlight_opened_office= false
			$TimerOfFlashlight.paused = true
			audio_buzzlight.stop()
			$TimerOfFlashlight.stop
			$bg.visible = false
			$Flashlight.visible = false
			$ColorRect.visible = false

	elif Global.flashlight_power == 0:
		flashed = false
		Global.flashlight_opened_office = false
		$TimerOfFlashlight.paused = true
		audio_buzzlight.stop()
		$TimerOfFlashlight.stop
		$bg.visible = false
		$Flashlight.visible = false
		$ColorRect.visible = false
		if Input.is_action_just_pressed("flashlight") && Global.monitor_opened == false:
			Global.flashlight_opened_office = false
			audio_error.play()
			audio_buzzlight.stop()
			$Flashlight.visible = false
			$ColorRect.visible = false
	$rooms/Cam0.visible = false
	$rooms/Cam01.visible = false
	$rooms/Cam02.visible = false
	$rooms/Cam03.visible = false
	$rooms/Cam04.visible = false
	$rooms/Cam05.visible = false
	$rooms/Cam06.visible = false
	$rooms/Cam07.visible = false
	$rooms/Cam08.visible = false
	$rooms/Cam09.visible = false
	$rooms/Cam10.visible = false
	$rooms/Cam11.visible = false
	get_node(rooms[Global.current_room]).visible = true
	$maps/Bitmap/buttons/zhushi.text = texts[Global.current_room]
	
	$maps/Bitmap/buttons/cam01/pressed.visible = false
	$maps/Bitmap/buttons/cam02/pressed.visible = false
	$maps/Bitmap/buttons/cam03/pressed.visible = false
	$maps/Bitmap/buttons/cam04/pressed.visible = false
	$maps/Bitmap/buttons/cam05/pressed.visible = false
	$maps/Bitmap/buttons/cam06/pressed.visible = false
	$maps/Bitmap/buttons/cam07/pressed.visible = false
	$maps/Bitmap/buttons/cam08/pressed.visible = false
	$maps/Bitmap/buttons/cam09/pressed.visible = false
	$maps/Bitmap/buttons/cam10/pressed.visible = false
	$maps/Bitmap/buttons/cam11/pressed.visible = false
	get_node(presseds[Global.current_room]).visible = true
	
	
	
	
func _on_timer_of_flashlight_timeout():
	if Global.flashlight_power > 1:
		$battery.frame +=1
	if Global.flashlight_power == 2:
		$battery.visible = false
		$AnimatedSprite2D.play("low_power")
		
	Global.flashlight_power -=1
	if Global.flashlight_power == 0:
		$battery.visible = true
		$AnimatedSprite2D.visible = false
	print('timeouted!')
	pass # Replace with function body.




func saveroom():
	if Global.saved_room != Global.current_room:
		Global.saved_room = 0

func _on_cam_01_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	Global.current_room = 1
	saveroom()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	pass # Replace with function body.


func _on_cam_02_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 2
	saveroom()
	pass # Replace with function body.


func _on_cam_03_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 3
	saveroom()
	pass # Replace with function body.


func _on_cam_04_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 4
	saveroom()
	pass # Replace with function body.


func _on_cam_05_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 5
	saveroom()
	pass # Replace with function body.


func _on_cam_06_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 6
	saveroom()
	pass # Replace with function body.


func _on_cam_07_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 7
	saveroom()
	pass # Replace with function body.


func _on_cam_08_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 8
	saveroom()


func _on_cam_09_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 9
	saveroom()


func _on_cam_10_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 10
	saveroom()


func _on_cam_11_pressed():
	$timers/Timer.stop()
	$Node2D/switch.play()
	$rooms/glitch.visible = false
	$rooms/Bot.visible = false
	Global.current_room = 11
	saveroom()
	
	



func _on_mask_button_mouse_entered():

	if Global.mask_opened == false:
		$mask.visible = true
		$Node2D/fansound.stop()
		$monitorButton.visible = false
		$fixbutton.visible = false
		$Node2D/wear.play()
		$mask.play("wear")
		await $mask.animation_finished
		$mask.play('breathe')


	
		
		Global.mask_opened = true
	elif Global.mask_opened == true:
		$Node2D/fansound.play()
		$Node2D/breathe.stop()
		$Node2D/tkoff.play()
		$mask.play_backwards('wear')
		await $mask.animation_finished
		$mask.visible = false
		$monitorButton.visible = true
		$fixbutton.visible = true
		Global.mask_opened = false
		

		
	pass # Replace with function body.


func _on_fansound_finished():
	$Node2D/fansound.play()
	pass # Replace with function body.


func _on_bgm_finished():
	$Node2D/bgm.play()
	pass # Replace with function body.


func _on_fixbutton_pressed():
	
	if Global.fixpad_opened == false:
		Global.fixpad_opened = true
		$monitorButton.visible = false
		$TextureButton.visible = false
		$maskButton.visible = false
		$fixpad.visible = true
		$Node2D/wear.play()
		$fixpad.play("default")
		await $fixpad.animation_finished
		
		$fixpad/Node2D.visible = true
		
	elif Global.fixpad_opened == true:
		
		Global.fixpad_opened = false
		$fixpad/Node2D.visible = false
		$Node2D/tkoff.play()
		$fixpad.play_backwards("default")
		await $fixpad.animation_finished
		$monitorButton.visible = true
		$maskButton.visible = true
		$TextureButton.visible = true
		$fixpad.visible = false
	pass # Replace with function body.


func _on_rebotdoor_mouse_entered():
	if rd_pressed == false:
		$fixpad/Node2D/rebotdoor.text = '>>大门'
	pass # Replace with function body.


func _on_rebotdoor_mouse_exited():
	if rd_pressed == false:
		$fixpad/Node2D/rebotdoor.text = '大门'
	pass # Replace with function body.


func _on_rebotdoor_pressed():
	var i:int = 0
	if rd_pressed == false:
		rd_pressed = true
		if Global.door_durability <5:
			while i <5:
				
				$Node2D/fixing.play()
				i +=1
				$fixpad/Node2D/rebotdoor.text = '>重启中...'+str(i)
				await get_tree().create_timer(4.75).timeout
				Global.door_durability +=1
				if Global.door_durability == 5:
					break
		$fixpad/Node2D/rebotdoor.text = '大门 已重启'
		$Node2D/done.play()
		rd_pressed = false
	pass # Replace with function body.


func _on_rebotmonitor_mouse_entered():
	if rm_pressed == false:
		$fixpad/Node2D/rebotmonitor.text = '>>监控'
	pass # Replace with function body.


func _on_rebotmonitor_mouse_exited():
	if rm_pressed == false:
		$fixpad/Node2D/rebotmonitor.text = '监控'
	pass # Replace with function body.
	


func _on_rebotmonitor_pressed():
	var i:int = 0
	if rm_pressed == false:
		rm_pressed = true
		while i <10:
			$Node2D/fixing.play()
			i +=1
			$fixpad/Node2D/rebotmonitor.text = '>重启中...'+str(i)+'0%'
			await get_tree().create_timer(1.5).timeout
			if i == 10:
				break
		$fixpad/Node2D/rebotmonitor.text = '监控 已重启'
		Global.monitor_broken = false
		$Node2D/done.play()
		rm_pressed = false
	pass # Replace with function body.


func _on_rebotaudio_mouse_entered():
	if ra_pressed == false:
		$fixpad/Node2D/rebotaudio.text = '>>音频'
	pass # Replace with function body.


func _on_rebotaudio_mouse_exited():
	if ra_pressed == false:
		$fixpad/Node2D/rebotaudio.text = '音频'
	pass # Replace with function body.


func _on_rebotaudio_pressed():
	var i:int = 0
	if ra_pressed == false:
		ra_pressed = true
		if Global.audio_durability <5:
			while i <5:
				
				$Node2D/fixing.play()
				i +=1
				$fixpad/Node2D/rebotaudio.text = '>重启中...'+str(i)
				await get_tree().create_timer(2.25).timeout
				Global.audio_durability +=1
				if Global.audio_durability == 5:
					break
		$fixpad/Node2D/rebotaudio.text = '音频 已重启'
		$Node2D/done.play()
		ra_pressed = false
	pass # Replace with function body.


func _on_playaudio_pressed():
	now_audio_playing = false
	var i :int = 0
	$maps/Label2.text = '.'
	var playwhat = randi() % 3

	if Global.audio_durability !=0:
		now_audio_playing = true
		Global.audio_durability -=1
		Global.audio_played_room = Global.current_room
		get_node(audio_sprites[Global.current_room]).visible = true
		get_node(audio_sprites[Global.current_room]).play()
		if playwhat == 0:
			$Node2D/AudioStreamPlayer2D9.play()
		elif playwhat == 1:
			$Node2D/AudioStreamPlayer2D10.play()
		elif playwhat == 2:
			$Node2D/AudioStreamPlayer2D11.play()
		$maps/Bitmap/playaudio.visible = false
		$maps/Label2.visible = true
		while true:
			$maps/Label2.visible = true
			await get_tree().create_timer(1).timeout
			i +=1
			
			if i == 0:
				$maps/Label2.text = '.'
			elif i == 1:
				$maps/Label2.text = '..'
			elif i == 2:
				$maps/Label2.text = '...'
			elif i == 3:
				$maps/Label2.text = '....'
			elif i == 4:
				$maps/Label2.text = '.....'
			if i == 5:
				get_node(audio_sprites[Global.audio_played_room]).visible = false
				now_audio_playing = false
				Global.audio_played_room = 0
				break
	if Global.audio_durability == 0:
		$Node2D/glitch.play()
				
		$maps/Label2.visible = false
		$maps/Bitmap/playaudio.visible = true
	pass # Replace with function body.



 # Replace with function body.



func _on_windup_button_down():
	$timers/Timer_gift.paused = true
	$timers/Timer.paused = false
	$timers/Timer.start()
	$timers/Timer.one_shot = false
	
	pass # Replace with function body.


func _on_windup_button_up():
	$timers/Timer_gift.paused = false
	$timers/Timer.one_shot = true
	$timers/Timer.paused = true
	
##################		AI HERE


func _on_timer_zhifen_timeout():
	if randi_range(1,20) <= Global.zhifen_ai:
		
		$rooms/static.visible = true
		$rooms/static.play()
		await $rooms/static.animation_finished
		$rooms/static.visible = false
		if Global.zhifen_currentroom == 03:
			
			if randi_range(0,1) == 1:
				Global.zhifen_currentroom = 06
				$Node2D/steps.play()
			else:
				Global.zhifen_currentroom = 02
				$Node2D/steps.play()
		#route 1
		elif Global.zhifen_currentroom == 06:
			Global.zhifen_currentroom = 12
			$timers/Timer_zhifen.paused = true
			$Node2D/windowscare.play()
			$timers/Timer_zhifen/waiting.wait_time = 10 - Global.currentnight
			$timers/Timer_zhifen/waiting.start()
			await $timers/Timer_zhifen/waiting.timeout
			if $timers/Timer_zhifen/waiting.timeout && Global.frontdoorClosed == true:
				$timers/Timer_zhifen/waiting.stop()
				$Node2D/punchdoor.play()
				Global.door_durability -= 1
				if Global.door_durability == 0:
					Global.zhifen_knockedout = true
				await get_tree().create_timer(3.15).timeout
				Global.zhifen_currentroom = 03
				await get_tree().create_timer(3.15).timeout
				$timers/Timer_zhifen.paused = false
			elif $timers/Timer_zhifen/waiting.timeout && Global.frontdoorClosed == false && Global.zhifen_currentroom == 12 && Global.currentTime != 6:
				$Node2D2/Office/characters/zhifen.visible = true
				$Node2D2/Office/characters/AnimationPlayer.play("zf_jumpscare")
				$"jumpscare mask".visible = true
				$Node2D/scream.play()
				$"jumpscare mask".visible = true
				$flashing.visible = true
				await $Node2D/scream.finished
				get_tree().change_scene_to_file("res://node_2d.tscn")
		#route 2
		elif Global.zhifen_currentroom == 02:
			$Node2D/steps.play()
			Global.zhifen_currentroom = 01
		elif Global.zhifen_currentroom == 01:
			$Node2D/steps.play()
			Global.zhifen_currentroom = 04
		elif Global.zhifen_currentroom == 04:
			Global.zhifen_currentroom = 08
			$Node2D/steps.play()
		elif Global.zhifen_currentroom == 08:
			Global.zhifen_currentroom = 12
			$timers/Timer_zhifen.paused = true
			$Node2D/windowscare.play()
			$timers/Timer_zhifen/waiting.wait_time = 10 - Global.currentnight
			$timers/Timer_zhifen/waiting.start()
			await $timers/Timer_zhifen/waiting.timeout
			if $timers/Timer_zhifen/waiting.timeout && Global.frontdoorClosed == true:
				$timers/Timer_zhifen/waiting.stop()
				$Node2D/punchdoor.play()
				Global.door_durability -= 1
				await get_tree().create_timer(3.15).timeout
				Global.zhifen_currentroom = 03
				await get_tree().create_timer(3.15).timeout
				$timers/Timer_zhifen.paused = false
				
			elif $timers/Timer_zhifen/waiting.timeout && Global.frontdoorClosed == false && Global.zhifen_currentroom == 12 && Global.currentTime != 6:
				Global.jumpscared = true
				$Node2D2/Office/characters/zhifen.visible = true
				$Node2D2/Office/characters/AnimationPlayer.play("zf_jumpscare")
				$Node2D/scream.play()
				$"jumpscare mask".visible = true
				$flashing.visible = true
				await $Node2D/scream.finished
				get_tree().change_scene_to_file("res://node_2d.tscn")
			
	pass # Replace with function body.

func _on_timer_mw_timeout():
	if randi_range(1,20) <= Global.mw_ai:
		$rooms/static.visible = true
		$rooms/static.play()
		await $rooms/static.animation_finished
		$rooms/static.visible = false
		if Global.mouthwash_currentroom == 10:
			if randi_range(0,5) == 0:
				Global.mouthwash_currentroom = 11
				$Node2D/vent.play()
			else:
				Global.mouthwash_currentroom = 9
			#route 1
		elif Global.mouthwash_currentroom == 11:
			Global.mouthwash_currentroom = 13
		elif Global.mouthwash_currentroom == 9:
			Global.mouthwash_currentroom = 8
		elif Global.mouthwash_currentroom == 8:
			Global.mouthwash_currentroom =4
		elif Global.mouthwash_currentroom == 4:
			Global.mouthwash_currentroom = 1
		elif Global.mouthwash_currentroom == 1:
			Global.mouthwash_currentroom = 2
		elif Global.mouthwash_currentroom ==2:
			Global.mouthwash_currentroom =3
		elif Global.mouthwash_currentroom == 3:
			Global.mouthwash_currentroom = 6
		elif Global.mouthwash_currentroom == 6:
			Global.mouthwash_currentroom =7
			$Node2D/vent2.play()
		elif Global.mouthwash_currentroom ==7:
			Global.mouthwash_currentroom =13
		#js
		if Global.mouthwash_currentroom == 13:
			$Node2D2/Office/characters/Mwwhat.visible = false
			await get_tree().create_timer(0.05).timeout
			$Node2D2/Office/characters/AnimationPlayer.play("mw_hey")
			$Node2D2/Office/characters/Mwhi.visible = true
			$Node2D/stare.play()
			$flashing.visible = true
			await $Node2D2/Office/characters/AnimationPlayer.animation_finished
			$Node2D/stare.stop()
			$flashing.visible = false
			if Global.mask_opened == true:
				$Node2D2/Office/characters/Mwhi.visible = false
				$Node2D2/Office/characters/Mwwhat.visible = true
				$Node2D2/Office/characters/AnimationPlayer.play('mw_what')
				await $Node2D2/Office/characters/AnimationPlayer.animation_finished
				Global.mouthwash_currentroom = 10
			elif Global.currentTime != 6 && Global.mask_opened == false:
				Global.jumpscared = true
				$Node2D2/Office/characters/AnimationPlayer.play("mw_jumpscare")
				$Node2D2/Office/characters/Mwwhat.visible = false
				$Node2D2/Office/characters/Mwhi.visible = true
				$Node2D/scream.play()
				$"jumpscare mask".visible = true
				$flashing.visible = true
				await $Node2D/scream.finished
				get_tree().change_scene_to_file("res://node_2d.tscn")
	pass # Replace with function body.


func _on_timer_evil_timeout():
	if randi_range(1,20) <= Global.evil_ai:
		$rooms/static.visible = true
		$rooms/static.play()
		await $rooms/static.animation_finished
		$rooms/static.visible = false
		if Global.evilbread_currentroom == 10:
			Global.evilbread_currentroom = 9
		elif Global.evilbread_currentroom == 9:
			Global.evilbread_currentroom =8
		elif Global.evilbread_currentroom == 8:
			Global.evilbread_currentroom =13
		if Global.evilbread_currentroom == 13:
			$"Node2D/windowscare-2".play()
			$Node2D2/Office/characters/Evil.visible = true
			$timers/Timer_evil/waiting.start()
			$timers/Timer_evil.paused = true
			await $timers/Timer_evil/waiting.timeout
			if Global.mask_opened == true && $timers/Timer_evil/waiting.timeout:
				Global.evilbread_currentroom = 10
				$Node2D2/Office/characters/Evil.visible = false
				$timers/Timer_evil.paused = false
			elif Global.mask_opened == false && $timers/Timer_evil/waiting.timeout:
				Global.flashlight_power = 0
				$battery.frame = 4
				
		
	pass # Replace with function body.


func _on_timer_ghost_timeout():
	if randi_range(1,20) <= Global.ghost_ai:
		$rooms/static.visible = true
		$rooms/static.play()
		await $rooms/static.animation_finished
		$rooms/static.visible = false
		if Global.ghostbread_currentroom == 9:
			Global.ghostbread_currentroom = 8
		elif Global.ghostbread_currentroom == 8:
			Global.ghostbread_currentroom = 12
		elif Global.ghostbread_currentroom == 12:
			$timers/Timer_ghost.paused = true
			await get_tree().create_timer(15).timeout
			if Global.ghostbread_flashed != 6  && Global.currentTime != 6:
				Global.jumpscared = true
				$Node2D2/Office/characters/Ghost.visible = true
				$Node2D2/Office/characters/AnimationPlayer.play("ghost_jumpscare")
				$Node2D/scream.play()
				$"jumpscare mask".visible = true
				$flashing.visible = true
				await $Node2D/scream.finished
				get_tree().change_scene_to_file("res://node_2d.tscn")
			
			
		
	pass # Replace with function body.


func _on_timer_warden_timeout():
	if randi_range(1,20) <= Global.warden_ai:
		$Node2D/steps.play()
		$rooms/static.visible = true
		$rooms/static.play()
		await $rooms/static.animation_finished
		$rooms/static.visible = false
		if Global.wardenbread_currentroom == 1:
			if randi_range(0,2) == 1:
				Global.wardenbread_currentroom = 4
			else:
				Global.wardenbread_currentroom = 2
		elif Global.wardenbread_currentroom == 2:
			Global.wardenbread_currentroom = 3
		elif Global.wardenbread_currentroom == 3:
			Global.wardenbread_currentroom = 6
		elif Global.wardenbread_currentroom == 4:
			Global.wardenbread_currentroom = 8
		elif Global.wardenbread_currentroom == 5:
			Global.wardenbread_currentroom = 4
		elif Global.wardenbread_currentroom == 6:
			Global.wardenbread_currentroom = 12
		elif Global.wardenbread_currentroom == 8:
			Global.wardenbread_currentroom = 12
		elif Global.wardenbread_currentroom == 9:
			Global.wardenbread_currentroom = 10
		elif Global.wardenbread_currentroom == 10:
			Global.wardenbread_currentroom = 12
	if Global.wardenbread_currentroom == 12 && Global.jumpscared == false:
			
			$timers/Timer_warden.paused = true
			$timers/Timer_warden/waiting.start()
			await $timers/Timer_warden/waiting.timeout
			if Global.wardenbread_currentroom == 12 && Global.frontdoorClosed == false && Global.currentTime != 6:
				Global.jumpscared = true
				print('jumpscared')
				$Node2D2/Office/characters/Warden.visible = true
				$Node2D2/Office/characters/AnimationPlayer.play("warden_jumpscare")
				$Node2D/scream.play()
				$"jumpscare mask".visible = true
				$flashing.visible = true
				await $Node2D/scream.finished
				get_tree().change_scene_to_file("res://node_2d.tscn")
			elif Global.wardenbread_currentroom == 12 && Global.frontdoorClosed == true && Global.currentTime != 6:
				$Node2D/punchdoor.play()
				Global.door_durability = 0
				await get_tree().create_timer(12).timeout
				if Global.wardenbread_currentroom == 12 && Global.frontdoorClosed == false && Global.currentTime != 6:
					Global.jumpscared = true
					print('jumpscared')
					$Node2D2/Office/characters/Warden.visible = true
					$Node2D2/Office/characters/AnimationPlayer.play("warden_jumpscare")
					$Node2D/scream.play()
					$"jumpscare mask".visible = true
					$flashing.visible = true
					await $Node2D/scream.finished
					get_tree().change_scene_to_file("res://node_2d.tscn")
				else:
					Global.wardenbread_currentroom = 1
	pass # Replace with function body.

func _on_timer_gift_timeout():
	Global.giftbread_spring -=1
	pass # Replace with function body.


func _on_timer_1_min_timeout():
	if Global.currentnight == 1:
		if Global.currentTime == 3:
			$timers/Timer_mw.start()
			$timers/Timer_zhifen.start()
			$timers/Timer_gift.start()
			print('started!')
		if Global.currentTime == 4:
			Global.zhifen_ai +=5
			Global.mw_ai +=5
	if Global.currentnight == 2:
		if Global.currentTime == 1:
			$timers/Timer_zhifen.start()
			$timers/Timer_mw.start()
			$timers/Timer_gift.start()
	if Global.currentnight == 3:
		if Global.currentTime == 1:
			$timers/Timer_evil.start()
			$timers/Timer_zhifen.start()
			$timers/Timer_mw.start()
			$timers/Timer_ghost.start()
	if Global.currentnight == 4:
		if Global.currentTime == 1:
			$timers/Timer_warden.start()
	pass # Replace with function body.


func _on_button_pressed():
	if Global.currentnight != 0 and Global.currentnight != 7:
		$Node2D3.visible = false
		get_node('Node2D/AudioStreamPlayer2D'+str(Global.currentnight)).stop()
	else:
		$Node2D3.visible = false
	pass # Replace with function body.


func _on_button_11_pressed():
	Global.currentTime += 1
	pass # Replace with function body.


func _on_audio_stream_player_2d_1_finished():
	$Node2D3.visible = false
	pass # Replace with function body.


func _on_audio_stream_player_2d_2_finished():
	$Node2D3.visible = false
	pass # Replace with function body.


func _on_audio_stream_player_2d_3_finished():
	$Node2D3.visible = false
	pass # Replace with function body.


func _on_audio_stream_player_2d_4_finished():
	$Node2D3.visible = false
	pass # Replace with function body.


func _on_audio_stream_player_2d_5_finished():
	$Node2D3.visible = false
	pass # Replace with function body.


func _on_audio_stream_player_2d_6_finished():
	$Node2D3.visible = false
	pass # Replace with function body.



func _on_timer_111_timeout():
	$Node2D2/Office/characters/Puppet2.visible = true
	$Node2D/musicbox.play()
	await get_tree().create_timer(30).timeout
	$Node2D/musicbox.stop()
	$Node2D/musicbox2.play()
	await $Node2D/musicbox2.finished
	$Node2D2/Office/characters/Puppet2.visible = false
	Global.jumpscared = true
	$Node2D/scream.play()
	$Node2D2/Office/characters/Puppet.visible = true
	$Node2D2/Office/characters/AnimationPlayer.play("puppet_jumpscare")
	$"jumpscare mask".visible = true
	$flashing.visible = true
	$"jumpscare mask".visible = true
	$flashing.visible = true
	await $Node2D/scream.finished
	get_tree().change_scene_to_file("res://node_2d.tscn")
	pass # Replace with function body.


func _on_timer_timeout():
	$Node2D/fixing.play()
	if Global.giftbread_spring < 20:
		Global.giftbread_spring += 1
	pass # Replace with function body.


func _on_texture_button_button_down():
	if Global.flashlight_power > 0:
		if Global.monitor_opened == false:
			if flashed == false && Global.ghostbread_currentroom == 12:
				flashed = true
				Global.ghostbread_flashed += 1
			Global.flashlight_opened_office = true
			$TimerOfFlashlight.paused = false
			audio_buzzlight.play()
			$bg.visible = true
			$Flashlight.visible = true
			$ColorRect.visible = true
		
	elif Global.flashlight_power == 0:
		flashed = false
		Global.flashlight_opened_office = false
		$TimerOfFlashlight.paused = true
		audio_buzzlight.stop()
		$TimerOfFlashlight.stop
		$bg.visible = false
		$Flashlight.visible = false
		$ColorRect.visible = false
		if Global.monitor_opened == false:
			Global.flashlight_opened_office = false
			audio_error.play()
			audio_buzzlight.stop()
			$Flashlight.visible = false
			$ColorRect.visible = false
			
	pass # Replace with function body.


func _on_texture_button_button_up():
	
	flashed = false
	Global.flashlight_opened_office= false
	$TimerOfFlashlight.paused = true
	audio_buzzlight.stop()
	$TimerOfFlashlight.stop
	$bg.visible = false
	$Flashlight.visible = false
	$ColorRect.visible = false

	pass # Replace with function body.
