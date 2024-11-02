extends Node2D


func _ready():
	print($".".get_child_count(true))
	$AnimationPlayer.play("new_animation_2")
	await $AnimationPlayer.animation_finished
	$AnimatedSprite2D2.visible = true
	$AnimatedSprite2D2.play()
	$bgmPlayer.play()
	await $AnimatedSprite2D2.animation_finished
	$AnimatedSprite2D2.visible = false
	$ColorRect3.visible = false
	$ColorRect4.visible = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
	pass
