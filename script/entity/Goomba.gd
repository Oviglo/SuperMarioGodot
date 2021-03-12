extends "res://script/entity/Enemy.gd"

func _ready():
	pass # Replace with function body.


func hurt():
	movement_speed = 0
	is_killed = true
	$CollisionShape2D.queue_free()
	$Sprite.play("crushed")
	
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
