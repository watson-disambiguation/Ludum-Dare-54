extends Node2D

class_name BattleManager
@onready var music_player = $MusicPlayer

var is_current: bool = false
# Called when the node enters the scene tree for the first time.
	
func set_current(value: bool):
	visible = value
	is_current = value
	music_player.playing = value

