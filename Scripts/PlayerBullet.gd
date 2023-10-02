extends Node2D

class_name PlayerBullet

var velocity: Vector2
var damage: float


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(position + velocity)
	position += velocity * delta


func _on_area_2d_area_entered(area):
	var enemy = area.get_parent()
	if enemy is Enemy:
		enemy.damage(damage)
		queue_free()
