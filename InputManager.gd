extends Node

@onready var _grid: Grid = $"../Grid"


func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("click"):
		var tile = _grid.getTileFromMouse(event.position.x,event.position.y)
		if tile != null: 
			tile.setValue(tile.getValue() + 1);
