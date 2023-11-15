extends "res://script/entity/Enemy.gd"

func _ready():
	pass # Replace with function body.


func crush():
	movement_speed = 0
	is_killed = true
	$CollisionShape2D.queue_free()
	$Sprite2D.play("crushed")
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
