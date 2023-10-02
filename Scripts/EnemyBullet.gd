extends Node2D

class_name EnemyBullet

@onready var battle: BattleManager = $".."

var velocity: Vector2
var damage: float


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not battle.is_current:
		return
	look_at(position + velocity)
	position += velocity * delta


func _on_area_2d_area_entered(area):
	var player = area.get_parent()
	if player is Robot:
		player.take_damage(damage)
		queue_free()
