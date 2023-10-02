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
@export var shot_cooldown: float = 1
@export var bullet_speed = 200
@export var damage = 10

@onready var battle: BattleManager = $".."
@onready var player = $"../Robot"
@onready var enemy_treads = $EnemyTreads
@onready var enemy_body = $EnemyRobot
@onready var game_over = $"../Game Over"
@onready var pickup_scene = preload("res://Scenes/pickup.tscn")
@onready var bullet_scene = preload("res://Scenes/enemy_bullet.tscn")

var _player_min_distance
var _player_max_distance
var health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	shot_cooldown_timer = shot_cooldown
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
	if not battle.is_current:
		return
	_update_range(delta)
	_move(delta)
	_try_shoot(delta)

var shot_cooldown_timer: float

func _try_shoot(delta):
	if shot_cooldown_timer < 0:
		_shoot()
		shot_cooldown_timer = shot_cooldown
	else:
		shot_cooldown_timer -= delta

func _shoot():
	var direction = (player.position - position).normalized()
	var bullet: EnemyBullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.velocity = bullet_speed * direction
	bullet.position = position
	bullet.damage = damage

func _move(delta):
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
	
func take_damage(damage_taken: float):
	health -= damage_taken
	print(health)
	if health <= 0:
		die()
	
func die():
	if randf_range(0,1) < pickup_spawn_prob:
		_spawn_pickup()
		game_over.enemies_killed += 1
		print(game_over.enemies_killed)
	queue_free()

func _spawn_pickup():
	var pickup = pickup_scene.instantiate()
	get_parent().add_child(pickup)
	pickup.position = position
