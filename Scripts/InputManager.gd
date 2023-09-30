extends Node

@onready var _grid: Grid = $"../Grid"


var hover_part: PartNode
var holding_part: PartNode

func _input(event):
	if event is InputEventMouse:
		if holding_part != null:
			holding_part.position = event.position
			_drop_part(event)
		else:
			if event.is_action_pressed("click") and hover_part != null:
				if hover_part.placed:
					_grid.removePart(hover_part.part.value)
					hover_part.placed = false
				holding_part = hover_part
		
func _drop_part(event):
	var in_bounds = _grid.hoverPart(event.position.x,event.position.y,holding_part.part)
	if event.is_action_pressed("click"):
		if _grid.placePart(event.position.x,event.position.y,holding_part.part):
			holding_part.position = _calc_place_pos(event.position)
			holding_part.placed = true
			holding_part = null
		# only drop the part if it isn't in the inventory
		if not in_bounds:
			holding_part = null
			
func _calc_place_pos(pos: Vector2) -> Vector2:
	var tile_size = _grid.tile_size
	var posInArray = _grid.getIndexFromPos(pos.x,pos.y)
	var width = (holding_part.part.layout2d.getWidth() - 1) * tile_size * 0.5
	var height = (holding_part.part.layout2d.getHeight() - 1) * tile_size * 0.5
	var output = posInArray * tile_size + Vector2(width,height)
	output += _grid.position
	return output
	
	
