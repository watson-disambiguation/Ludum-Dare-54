extends Control

class_name ToolTip

@onready var name_textbox: Label = $Name
@onready var desc_textbox: Label = $Description

func set_tooltip(pos: Vector2, name_text: String, desc_text: String):
	visible = true
	name_textbox.text = name_text
	desc_textbox.text = desc_text
	var height = name_textbox.size.y + desc_textbox.size.y
	set_position(pos)

func hide_tooltip():
	visible = false
