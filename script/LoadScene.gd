extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
		print($".".get_child_count(true))
		$Nspp.visible = false
		if Global.newgame == true:
			Global.newgame = false
			$Nspp.visible = true
			$AnimationPlayer.play("new_animation")
			await $AnimationPlayer.animation_finished
			$Label.visible = true
			$Timer3.start()
			await $Timer3.timeout
		$Timer.start()
		$Label.text = '第'+str(Global.currentnight)+'夜\n'+'12:00 AM'
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play()
		await  $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.visible = false
		#testing!
		Global.SaveGame()


func _on_timer_timeout():
	$Label.visible = false
	$LoadingClock.visible = true
	pass # Replace with function body.
	$AnimationPlayer.play("new_animation_2")
	$Timer2.start()
func _on_timer_2_timeout():
	get_tree().change_scene_to_file("res://scenes/gameplay.tscn")
	pass # Replace with function body.
