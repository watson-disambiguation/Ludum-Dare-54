extends Node2D

class_name Grid

@export var width: int = 0
@export var height: int = 0
var _grid: Array2D
var _tile_scene = preload("res://inventory_tile.tscn") 
var _tile_size: int
# Called when the node enters the scene tree for the first time.
func _ready():
	_grid = Array2D.new(width,height)
	for x in range(0,width):
		for y in range(0,height):
			var tile = _tile_scene.instantiate()
			add_child(tile)
			_tile_size = tile.getSize()
			tile.position.x = _tile_size * x
			tile.position.y = _tile_size * y
			tile.setValue(0)
			_grid.setItem(tile,x,y)
			
func getTileFromMouse(x, y) -> InventoryTile:
	var index_x = ceil((x - position.x) / _tile_size - 0.5)
	var index_y = ceil((y - position.y) / _tile_size - 0.5)
	var in_bounds_x = (index_x >= 0) and (index_x < width)
	var in_bounds_y = (index_y >= 0) and (index_y < height)
	print("%d %d" % [index_x,index_y])
	if(in_bounds_x and in_bounds_y):
		return _grid.getItem(index_x,index_y)
	else:
		return null
	


