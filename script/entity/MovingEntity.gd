extends KinematicBody2D

export(int, "Walk") var movement_type = 0
export(int, 1, 100) var movement_speed = 25
enum Direction {LEFT = -1, RIGHT = 1}
export(Direction) var movement_direction = -1

var velocity = Vector2.ZERO
var acceleration = 10
var friction = 0
var gravity = 600
var is_active = false

func _physics_process(delta):
	if movement_type == 0:
		walk_process(delta)
		

func walk_process(delta):
	velocity.x = movement_speed * movement_direction
	velocity.y += delta * gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# wall collision
	if is_on_wall():
		movement_direction *= -1
