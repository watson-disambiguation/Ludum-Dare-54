extends Node2D

class_name Enemy

@export var pickup_spawn_prob: float = 0.5
@export var player_min_distance: float = 50
@export var player_max_distance: float = 200
@export var player_distance_range: float = 30
@export var min_player_dist_update_time: float = 3
@export var max_player_dist_update_time: float = 10
@export var speed: float = 60
@export var max_health: float = 60

@onready var player = $"../Robot"
@onready var enemy_treads = $EnemyTreads
@onready var enemy_body = $EnemyRobot
@onready var pickup_scene = preload("res://Scenes/pickup.tscn")

var _player_min_distance
var _player_max_distance
var health = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	_update_range(0)

func _update_range(delta):
	if _range_update_timer > 0:
		_range_update_timer -= delta
		return
	_player_min_distance = randf_range(player_min_distance,player_max_distance)
	_player_max_distance = _player_min_distance + player_distance_range
	_range_update_timer = randf_range(min_player_dist_update_time,max_player_dist_update_time)

var _circle_dir = 0
var _range_update_timer = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_range(delta)
	var move_dir = Vector2.ZERO
	var seperation: Vector2 = player.position - position
	var player_dir = seperation.normalized()
	var dist = seperation.length()
	if dist < _player_min_distance:
		move_dir = -player_dir
		_circle_dir = randi_range(0,1)
	elif dist > _player_max_distance:
		move_dir = player_dir
		_circle_dir = randi_range(0,1)
	else:
		move_dir = player_dir.rotated(PI/2)
		if _circle_dir:
			move_dir = -move_dir
	enemy_body.look_at(player.position)
	enemy_treads.look_at(position + move_dir)
	position += move_dir * delta * speed
	
func damage(damage: float):
	health -= damage
	if health <= 0:
		die()
	
func die():
	if randf_range(0,1) < pickup_spawn_prob:
		_spawn_pickup()
	queue_free()

func _spawn_pickup():
	var pickup = pickup_scene.instantiate()
	get_parent().add_child(pickup)
	pickup.position = position
