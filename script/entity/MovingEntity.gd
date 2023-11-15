extends CharacterBody2D

@export var movement_type = 0 # (int, "Walk")
@export var movement_speed = 25 # (int, 1, 100)
enum Direction {LEFT = -1, RIGHT = 1}
@export var movement_direction: Direction = -1

var acceleration = 10
var friction = 0
var gravity = 600
var is_active = false

func _physics_process(delta):
	if !is_active:
		if get_parent().get_node("Player"):
			var player_distance = position.distance_to(get_parent().get_node("Player").position)
			if player_distance < 250:
				is_active = true
		else:
			return
	
	if movement_type == 0 and is_active:
		walk_process(delta)
		$Sprite2D.visible = true

func walk_process(delta):
	if movement_speed > 0:
		velocity.x = movement_speed * movement_direction
		velocity.y += delta * gravity
	
		set_velocity(velocity)
		set_up_direction(Vector2.UP)
		move_and_slide()
		velocity = velocity
		$Sprite2D.flip_h = movement_direction < 1
		# wall collision
		if is_on_wall():
			movement_direction *= -1
			
