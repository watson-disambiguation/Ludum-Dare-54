extends Node

class_name PartList

var _part_list: Array = []
var _smallest_free_index: int = 0

func _init():
	_part_list = []
	_smallest_free_index = 0
	
func get_free_index() -> int:
	return _smallest_free_index

func get_item(index: int):
	return _part_list[index]
	
func add_item(item) -> int:
	var index_added_to: int = 0
	if _smallest_free_index >= _part_list.size():
		_part_list.append(item)
		index_added_to = _part_list.size() - 1
		_smallest_free_index = _part_list.size()
		return index_added_to
	else:
		_part_list[_smallest_free_index] = item
		index_added_to = _smallest_free_index
		var index_found = false
		for i in range(_smallest_free_index + 1,_part_list.size()):
			if _part_list[i] == null:
				_smallest_free_index = i
				index_found = true
				break
		if not index_found: 
			_smallest_free_index = _part_list.size()
	return index_added_to
func remove_item(index: int):
	
	var item = _part_list[index]
	_part_list[index] = null
	if _smallest_free_index > index:
		_smallest_free_index = index
	print(_smallest_free_index)
	return item
