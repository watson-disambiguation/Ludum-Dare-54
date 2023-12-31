extends Node2D

class_name EnemySpawner

@onready var battle: BattleManager = $".."

@export var min_spawn_dist_x: float = 360
@export var max_spawn_dist_x: float = 400
@export var min_spawn_dist_y: float = 203
@export var max_spawn_dist_y: float = 240
@export var min_spawn_interval: float = 1
@export var max_spawn_interval: float = 5

@onready var enemy_scene = preload("res://Scenes/enemy.tscn")

var _time_since_spawn = 0
var _spawn_interval = max_spawn_interval
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not battle.is_current:
		return
	if _time_since_spawn > 0:
		_time_since_spawn -= delta
	else:
		_time_since_spawn = _spawn_interval
		spawn()
		_spawn_interval
	
	
func spawn():
	var pos = get_spawn_pos()
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.position = pos
func get_spawn_pos() -> Vector2:
	var x = randf_range(min_spawn_dist_x,max_spawn_dist_x)
	var y = randf_range(min_spawn_dist_y,max_spawn_dist_y)
	var x_negative = randi_range(0,1)
	var y_negative = randi_range(0,1)
	if x_negative:
		x = -x
	if y_negative:
		y = -y
	return position + Vector2(x,y)
