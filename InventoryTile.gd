extends Node2D

class_name InventoryTile

@onready var label: Label = $Label

var _value = 0

func setValue(value):
	_value = value
	label.text = str(_value)
	
func getValue():
	return _value

func getSize():
	return label.size.x * transform.get_scale().x
