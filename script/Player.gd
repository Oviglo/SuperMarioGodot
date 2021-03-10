extends KinematicBody2D

var speed = 100
var jump_speed = -300
var gravity = 600
var friction = 0.4
var acceleration = 0.4
var velocity = Vector2.ZERO
var direction = 1
var is_jumping = false
var is_animate = true
var is_moving = true

var state = 0

func get_input():
	if Input.is_action_pressed("walk_right"):
		direction = 1
		if !is_jumping and is_animate:
			play_animation("walk")
		velocity.x = lerp(velocity.x, 1* speed, acceleration)
	elif Input.is_action_pressed("walk_left"):
		direction = -1
		
		if !is_jumping and is_animate:
			play_animation("walk")
		velocity.x = lerp(velocity.x, -1 * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if !is_jumping and is_animate:
			play_animation("idle")
			
	$AnimatedSprite.flip_h = direction < 0

func _physics_process(delta):
	if is_moving:
		get_input()
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() and is_moving:
			velocity.y = jump_speed
			is_jumping = true
			play_animation("jump")
	elif is_on_floor():
		is_jumping = false

# Animation
func play_animation(name):
	name += ("_" + str(state))
	$AnimatedSprite.play(name)

#Power up
func power_up():
	is_moving = false
	is_animate = false
	$AnimatedSprite.play("powerup")
	state = 1
	$CollisionShape2D.shape.set_deferred("extents", Vector2(4, 12))
	$CollisionShape2D.position.y = 4


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "powerup":
		is_moving = true
		is_animate = true
