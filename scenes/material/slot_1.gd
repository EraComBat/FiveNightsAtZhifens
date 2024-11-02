extends TextureRect
@export_multiline var text:String
@onready var label = $PanelContainer/MarginContainer/Label
@onready var panel_container = $PanelContainer
func _ready():
	label.text = text
func _on_mouse_entered():
	panel_container.visible = true


func _on_mouse_exited():
	panel_container.visible = false
