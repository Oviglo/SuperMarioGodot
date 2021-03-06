extends KinematicBody2D

var speed = 100
var jump_speed = -300
var gravity = 600
var friction = 0.4
var acceleration = 0.4
var velocity = Vector2.ZERO
var direction = 1
var is_jumping = false

func get_input():
	if Input.is_action_pressed("walk_right"):
		direction = 1
		if !is_jumping:
			$AnimatedSprite.play("walk")
		velocity.x = lerp(velocity.x, 1* speed, acceleration)
	elif Input.is_action_pressed("walk_left"):
		direction = -1
		
		if !is_jumping:
			$AnimatedSprite.play("walk")
		velocity.x = lerp(velocity.x, -1 * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if !is_jumping:
			$AnimatedSprite.play("idle")
			
	$AnimatedSprite.flip_h = direction < 0

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			is_jumping = true
			$AnimatedSprite.play("jump")
	elif is_on_floor():
		is_jumping = false
