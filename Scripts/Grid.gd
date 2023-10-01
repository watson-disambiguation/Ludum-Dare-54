extends Node2D

class_name Grid

@export var width: int = 0
@export var height: int = 0
var _grid: Array2D
var _tile_scene = preload("res://Scenes/inventory_tile.tscn") 
@export var tile_size: float = 32
# Called when the node enters the scene tree for the first time.
func _ready():
	_grid = Array2D.new(width,height)
	for x in range(0,width):
		for y in range(0,height):
			var tile = _tile_scene.instantiate()
			add_child(tile)

			tile.position.x = tile_size * x
			tile.position.y = tile_size * y
			tile.setValue(-1)
			_grid.setItem(tile,x,y)
			
func getIndexFromPos(x, y) -> Vector2i:
	var index_x = ceil((x - position.x) / tile_size - 0.5)
	var index_y = ceil((y - position.y) / tile_size - 0.5)
	return Vector2i(index_x,index_y)

func placePart(mouse_x,mouse_y,part: RobotPart, index: int) -> bool:
	for tile in _grid:
		tile.setClear()	
	
	var arrayPos = getIndexFromPos(mouse_x,mouse_y)
	var partArray2d: Array2D = part.layout2d
	
	# check if any overlap
	for x in range(0,partArray2d.getWidth()):
		for y in range(0,partArray2d.getHeight()):
			var x_pos = x+arrayPos.x
			var y_pos = y+arrayPos.y
			var in_bounds_x = (x_pos < _grid.getWidth()) and (x_pos >= 0)
			var in_bounds_y = (y_pos < _grid.getHeight()) and (y_pos >= 0)
			
			if not (in_bounds_x and in_bounds_y):
				return false
			var tile_value = _grid.getItem(x+arrayPos.x,y+arrayPos.y).getValue()
			if tile_value != -1 and partArray2d.getItem(x,y):
				return false
	
	for x in range(0,partArray2d.getWidth()):
		for y in range(0,partArray2d.getHeight()):	
			var part_value = partArray2d.getItem(x,y)
			if part_value:
				_grid.getItem(x+arrayPos.x,y+arrayPos.y).setValue(index)
	
	return true	

	
func hoverPart(mouse_x,mouse_y,part: RobotPart) -> bool:
	var arrayPos = getIndexFromPos(mouse_x,mouse_y)
	var partArray2d: Array2D = part.layout2d
	var in_bounds = false
	
	for tile in _grid:
		tile.setClear()
	
	
	for x in range(0,partArray2d.getWidth()):
		for y in range(0,partArray2d.getHeight()):
			var x_pos = x+arrayPos.x
			var y_pos = y+arrayPos.y
			var in_bounds_x = (x_pos < _grid.getWidth()) and (x_pos >= 0)
			var in_bounds_y = (y_pos < _grid.getHeight()) and (y_pos >= 0)
			
			if not (in_bounds_x and in_bounds_y):
				continue
			in_bounds = true
			var tile = _grid.getItem(x+arrayPos.x,y+arrayPos.y)
			if (tile.getValue() != -1) and partArray2d.getItem(x,y):
				tile.setForbidden()
			elif partArray2d.getItem(x,y):
				tile.setAllowed()
	return in_bounds

func removePart(value: int):
	for tile in _grid:
		if tile.getValue() == value:
			tile.setValue(-1)
