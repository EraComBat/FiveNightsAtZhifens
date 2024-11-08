extends Node2D

#class_name OfficeScroll

const SCROLL_SMOOTHING : int = 12 # Lower for smoother scrolling
const SCROLL_SPEED : float = 0.10 # Lower for faster scrolling
const SCROLL_CLAMP : int = 70 # Clamps office scrolling on both sides

# An export made for objects hitboxes that need an offset due to the equirectangular shader
# Reminder that for each object there needs to be an Array of an Array to work
# [NodePath, EdgeSpeed_x(int), SpeedClamp_left(int), SizeClamp_right(int)]
@export var item_offsets : Array = []

var scroll_area : Dictionary = { "Left": 0, "Right": 0 }

var scroll_amount : float = 0

func _ready():
	$Office/ColorRect.visible = true
	
	var view_size_x : float = get_viewport().content_scale_size.x
	# Made to fix a 1 pixel issue at the right of the screen when view_size_x isn't a whole number
	var border_correcter_x : float = 1/(get_viewport().size.x/view_size_x)
	
	# This calculates the scroll area on both sides of the screen
	scroll_area["Left"] = view_size_x / 3
	scroll_area["Right"] = view_size_x - (scroll_area["Left"] + border_correcter_x)
	

func _physics_process(delta):
	if Global.currentTime == 6 or Global.jumpscared == true:
		$Office/fan.stop()
		var view_size_x : float = get_viewport().content_scale_size.x
		var border_correcter_x : float = 1/(get_viewport().size.x/view_size_x)
		scroll_area["Left"] = view_size_x / 65535
		scroll_area["Right"] = view_size_x - (scroll_area["Left"] + border_correcter_x)
	var mouse_position : Vector2 = get_global_mouse_position()
	
	if Global.currentTime != 6 or !Global.monitor_opened or !Global.jumpscared:
		# Checks if the mouse is within one of the scroll areas, and scrolls if it is
		if mouse_position.x < scroll_area["Left"]:
			scroll_amount += (scroll_area["Left"] - mouse_position.x) * SCROLL_SPEED
		elif mouse_position.x > scroll_area["Right"]:
			scroll_amount += (scroll_area["Right"] - mouse_position.x) * SCROLL_SPEED
	
		scroll_amount = clamp(scroll_amount, -SCROLL_CLAMP, SCROLL_CLAMP)
	
		# Clamps the position so the office doesn't leave the frame
		position.x = lerp(position.x, scroll_amount, SCROLL_SMOOTHING * delta)
		apply_offset(scroll_amount, delta)

func apply_offset(scroll_modifier : float, delta : float):
	# Modifies the buttons collision postion, makes it so the button is pressable with the shader
	for i in item_offsets:
		i[0].position.x = clamp((position.x - i[1] + i[0].position.x/2) + scroll_modifier * delta, i[2], i[3])
