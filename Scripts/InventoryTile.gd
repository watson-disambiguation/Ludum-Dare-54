extends Node2D

class_name InventoryTile

@onready var allowed_tile = $AllowedTile
@onready var forbidden_tile = $ForbiddenTile
@onready var label = $Label


var _value = 0

func setValue(value):
	label.text = str(value)
	_value = value
	
func getValue():
	return _value
	
func setAllowed():
	allowed_tile.visible = true
	forbidden_tile.visible = false
func setForbidden():
	allowed_tile.visible = false
	forbidden_tile.visible = true
func setClear():
	allowed_tile.visible = false
	forbidden_tile.visible = false
