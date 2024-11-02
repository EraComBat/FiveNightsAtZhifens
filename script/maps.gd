extends Node2D
@onready var audio_put_down = $Node2D/put_down
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.monitor_broken == true:
		$"../rooms/glitch".visible = false
		$"../rooms/Bot".visible = false
	
	
	if Global.jumpscared == true:
		Global.jumpscared = false
		if Global.monitor_opened == true:
			$"../rooms".visible = false
			$".".visible = false
			$"../pad".visible = true
			$"../pad".play_backwards('lift')
			await $"../pad".animation_finished
			$"../pad".visible = false
			Global.monitor_opened = false
	
	
	
	if Global.monitor_opened == true && Global.currentTime == 6 :
		$"../rooms".visible = false
		$".".visible = false
		$"../pad".visible = true
		$"../pad".play_backwards('lift')
		await $"../pad".animation_finished
		$"../pad".visible = false
		Global.monitor_opened = false
	pass





func _on_texture_button_button_down():
	if $tilemap.visible == false:
		$tilemap.visible = true
		$Bitmap/buttons.visible = false
	elif $tilemap.visible == true:
		$tilemap.visible = false
		$Bitmap/buttons.visible = true
	pass # Replace with function body.



func _on_monitor_button_mouse_entered():
	
	if Global.monitor_opened == false:
		$"../TextureButton".visible = false
		Global.monitor_opened = true
		$"../maskButton".visible = false
		$"../fixbutton".visible = false
		$"../Node2D/put_down".play()
		$"../pad".visible = true
		$"../Node2D/fansound".stop()
		$"../pad".play('lift')
		await $"../pad".animation_finished
		$"../Node2D2/Office/ColorRect".visible = false
		$"../Black3".visible = true
		$".".visible = true
		$"../rooms".visible = true
		$"../pad".visible = false
		if Global.bot_ai != 0:
			if randi_range(0,20)  <= Global.bot_ai && Global.monitor_broken == false:
				Global.saved_room = Global.current_room
				$"../rooms/glitch".visible = true
				$"../rooms/Bot".visible = true
				await get_tree().create_timer(1).timeout
				if Global.monitor_opened == true:
					if Global.saved_room == Global.current_room:
						
						Global.monitor_broken = true
						await get_tree().create_timer(0.3).timeout
						$"../rooms/glitch".visible = false
						$"../rooms/Bot".visible = false
					else:
						$"../rooms/glitch".visible = false
						$"../rooms/Bot".visible = false
				elif Global.monitor_opened == false:
					Global.saved_room = 0
					$"../rooms/glitch".visible = false
					$"../rooms/Bot".visible = false
	elif Global.monitor_opened == true :
		$"../Node2D/put_down".play()
		$"../rooms".visible = false
		$".".visible = false
		$"../Black3".visible = false
		$"../pad".visible = true
		$"../Node2D/fansound".play()
		$"../Node2D2/Office/ColorRect".visible = true
		$"../pad".play_backwards('lift')
		await $"../pad".animation_finished
		$"../pad".visible = false
		$"../fixbutton".visible = true
		$"../maskButton".visible = true
		$"../TextureButton".visible = true
		Global.monitor_opened = false
		
	pass # Replace with function body.
