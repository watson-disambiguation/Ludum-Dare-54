extends RefCounted

class_name Array2D

var _width: int
var _height: int
var _array = []

func _init(width: int, height: int):
	_width = width
	_height = height
	_array = []
	for i in range(0,_width):
		var innerArray = []
		innerArray.resize(_height)
		_array.append(innerArray)

static func fromArray(array: Array) -> Array2D:
	var height = array.size()
	var width = array[0].size()
	var array2d = Array2D.new(width,height)
	for x in range(0,width):
		for y in range(0,height):
			if not array[y] is Array:
				continue
			if array[y].size() > 0:
				array2d.setItem(array[y][x],x,y)
	return array2d

		
func getWidth():
	return _width
	
func getHeight():
	return _height

func getItem(x: int, y: int):
	return _array[x][y]
	
func setItem(item, x: int, y: int):
	_array[x][y] = item
	
func fill(item):
	for x in range(0,_width):
		for y in range(0,_height):
			_array[x][y] = item

# iterator
var _iter_x: int = 0
var _iter_y: int = 0

func _can_continue():
	return _iter_x < _width and _iter_y < _height

func _iter_init(arg):
	_iter_x = 0
	_iter_y = 0
	return _can_continue()
	
func _iter_next(arg):
	_iter_x += 1
	if _iter_x >= _width:
		_iter_x = 0
		_iter_y += 1
	return _can_continue()

func _iter_get(arg):
	return _array[_iter_x][_iter_y]
	
func _to_string():
	var output: String = ""
	for y in range(0,_height):
		for x in range(0,_width):
			output += (str(_array[x][y]) + " ")
		output += "\n"
	return output
			
