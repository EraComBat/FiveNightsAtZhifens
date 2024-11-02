extends TextureButton

const SCROLL_SMOOTHING : int = 12 # Lower for smoother scrolling
const SCROLL_SPEED : float = 0.10 # Lower for faster scrolling
const SCROLL_CLAMP : int = 750 # Clamps office scrolling on both sides

# An export made for objects hitboxes that need an offset due to the equirectangular shader
# Reminder that for each object there needs to be an Array of an Array to work
# [NodePath, EdgeSpeed_x(int), SpeedClamp_left(int), SizeClamp_right(int)]
@export var item_offsets : Array = []

var scroll_area : Dictionary = { "Left": 0, "Right": 0 }

var scroll_amount : float = 0

func _ready():
	Global.door_durability = 5
	var view_size_x : float = get_viewport().content_scale_size.x
	# Made to fix a 1 pixel issue at the right of the screen when view_size_x isn't a whole number
	var border_correcter_x : float = 1/(get_viewport().size.x/view_size_x)
	
	# This calculates the scroll area on both sides of the screen
	scroll_area["Left"] = view_size_x / 3
	scroll_area["Right"] = view_size_x - (scroll_area["Left"] + border_correcter_x)
	

func _physics_process(delta):
	#var mouse_position : Vector2 = get_global_mouse_position()
	#
	#if !Global.monitor_opened:
		## Checks if the mouse is within one of the scroll areas, and scrolls if it is
		#if mouse_position.x < scroll_area["Left"]:
			#scroll_amount += (scroll_area["Left"] - mouse_position.x) * SCROLL_SPEED
		#elif mouse_position.x > scroll_area["Right"]:
			#scroll_amount += (scroll_area["Right"] - mouse_position.x) * SCROLL_SPEED
	
	scroll_amount = clamp(scroll_amount, SCROLL_CLAMP, -SCROLL_CLAMP)
	
	# Clamps the position so the office doesn't leave the frame
	position.x = lerp(position.x, scroll_amount, SCROLL_SMOOTHING * delta)
	apply_offset(-scroll_amount, delta)

func apply_offset(scroll_modifier : float, delta : float):
	# Modifies the buttons collision postion, makes it so the button is pressable with the shader
	for i in item_offsets:
		i[0].position.x = clamp((position.x - i[1] + i[0].position.x/2) + scroll_modifier * delta, i[2], i[3])




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.door_durability == 0 && Global.frontdoorClosed == true && Global.zhifen_knockedout == true:
		Global.zhifen_knockedout = false
		Global.frontdoorClosed = false
		$"../../../Node2D/doorfx".play()
		$"../Door".visible = false
	pass


func _on_pressed():
	if Global.frontdoorClosed == false && Global.door_durability >1:
		$Timer.start()
		Global.frontdoorClosed = true
		Global.door_durability -=1
		$"../Door".visible = true
	
		$"../../../Node2D/close".play()
	elif Global.frontdoorClosed == false && Global.door_durability == 1:
		$"../../../Node2D/doorfx".play()
		Global.frontdoorClosed = true
		Global.door_durability -=1
		$"../Door".visible = true
		
	elif Global.frontdoorClosed == false && Global.door_durability ==0:

		$"../../../Node2D/doorfx".play()
	elif Global.frontdoorClosed == true:
		Global.frontdoorClosed = false
		$"../Door".visible = false
		$Timer.stop()
		$"../../../Node2D/open".play()
	pass # Replace with function body.
	


func _on_timer_timeout():
	if Global.frontdoorClosed == true:
		Global.frontdoorClosed = false
		$"../Door".visible = false
		$"../../../Node2D/open".play()
	pass # Replace with function body.
