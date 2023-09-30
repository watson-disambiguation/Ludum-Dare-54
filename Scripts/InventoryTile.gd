extends Node2D

class_name InventoryTile

@onready var label: Label = $Label
@onready var allowed_tile = $AllowedTile
@onready var forbidden_tile = $ForbiddenTile

var _value = 0

func setValue(value):
	_value = value
	label.text = str(_value)
	
func getValue():
	return _value

func getSize():
	return label.size.x * transform.get_scale().x
	
func setAllowed():
	allowed_tile.visible = true
	forbidden_tile.visible = false
func setForbidden():
	allowed_tile.visible = false
	forbidden_tile.visible = true
func setClear():
	allowed_tile.visible = false
	forbidden_tile.visible = false
