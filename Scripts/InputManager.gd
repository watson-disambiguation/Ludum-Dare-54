extends Node

@onready var _grid: Grid = $"../Grid"
@onready var part_list = $"../../PartList"
@onready var tool_tip: ToolTip = $"../ToolTip"
@onready var menu: MenuManager = $".."
@onready var sfx_player = $"../SFXPlayer"
@onready var pickup = preload("res://Audio/SFX/Pickup.wav")
@onready var drop = preload("res://Audio/SFX/Drop.wav")

var hover_part: PartNode
var holding_part: PartNode

func _input(event):
	if not menu.is_current:
		return
	if event is InputEventMouse:
		if holding_part != null:
			holding_part.position = event.position
			_drop_part(event)
		else:
			if hover_part != null:
				if event.is_action_pressed("main_click"):
					sfx_player.stream = pickup
					sfx_player.play()
					if hover_part.placed:
						_grid.removePart(hover_part.value)
						part_list.remove_item(hover_part.value)
						hover_part.placed = false	
					holding_part = hover_part
		if hover_part != null and event.is_action_pressed("secondary_click"):
			tool_tip.set_tooltip(event.position,hover_part.part.name,hover_part.part.description)
		if event.is_action_released("secondary_click"):
			tool_tip.hide_tooltip()

func _drop_part(event):
	var in_bounds = _grid.hoverPart(event.position.x,event.position.y,holding_part.part)
	sfx_player.stream = drop
	if event.is_action_pressed("main_click"):
		var index = part_list.get_free_index()
		if _grid.placePart(event.position.x,event.position.y,holding_part.part, index):
			sfx_player.play()
			holding_part.position = _calc_place_pos(event.position)
			holding_part.value = index
			part_list.add_item(holding_part.part)
			holding_part.placed = true
			holding_part = null
		# only drop the part if it isn't in the inventory
		if not in_bounds:
			sfx_player.play()
			holding_part = null
			
func _calc_place_pos(pos: Vector2) -> Vector2:
	var tile_size = _grid.tile_size
	var posInArray = _grid.getIndexFromPos(pos.x,pos.y)
	var width = (holding_part.part.layout2d.getWidth() - 1) * tile_size * 0.5
	var height = (holding_part.part.layout2d.getHeight() - 1) * tile_size * 0.5
	var output = posInArray * tile_size + Vector2(width,height)
	
	output += _grid.position
	
	return output
	
	
