extends Node2D

class_name ModeSwitcher

var start_button: Button 
@onready var battle = $Battle
@onready var main_menu: MenuManager = $MainMenu
@onready var robot: Robot = $Battle/Robot
@onready var part_list: PartList = $PartList
@onready var part_spawner: PartSpawner = $MainMenu/PartSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	start_button = $"MainMenu/StartButton"
	start_button.button_up.connect(open_battle)
	battle.set_current(false)
	main_menu.set_current(true)

func open_battle():
	battle.set_current(true)
	main_menu.set_current(false)
	robot.apply_parts(part_list.get_array())
	
func open_menu():
	battle.set_current(false)
	main_menu.set_current(true)
	part_spawner.spawn()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
