extends CharacterBody2D

var speed = 90
var walk_speed = 90
var run_speed = 130
var jump_speed = -300
var gravity = 600
var friction = 0.2
var acceleration = 0.15
var direction = 1
var is_jumping = false
var is_falling = false
var is_animate = true
var is_moving = true
var is_dead = false
var is_hurted = false

var score = 0
var coins = 0
var state = 0

signal score_changed
signal coins_changed
signal dead

func get_input():
	var animation_name = ""
	if Input.is_action_pressed("walk_right"):
		if !is_jumping and !is_falling:
			direction = 1
		animation_name = "walk"
		velocity.x = lerp(velocity.x, 1.0 * speed, acceleration)
	elif Input.is_action_pressed("walk_left"):
		if !is_jumping and !is_falling:
			direction = -1
		animation_name = "walk"
		velocity.x = lerp(velocity.x, -1.0 * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		animation_name = "idle"
		
	if !is_jumping and !is_falling and is_animate:
		friction = 0.2
		acceleration = 0.15
		play_animation(animation_name)
	elif is_animate:
		friction = 0.05
		acceleration = 0.05
		play_animation("jump")
		
	# Run
	if Input.is_action_just_pressed("run"):
		speed = run_speed
		
	if Input.is_action_just_released("run"):
		speed = walk_speed
	
	$AnimatedSprite2D.flip_h = direction < 0
	update_areas()

func _physics_process(delta):
	if is_moving:
		is_jumping = velocity.y < 0
		is_falling = velocity.y > 0
		get_input()
		
		velocity.y += gravity * delta
		
		set_velocity(velocity)
		set_up_direction(Vector2.UP)
		move_and_slide()
		velocity = velocity
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() and is_moving:
			velocity.y = jump_speed

# Animation
func play_animation(name):
	name += ("_" + str(state))
	$AnimatedSprite2D.play(name)

#Power up
func power_up():
	is_moving = false
	is_animate = false
	$AnimatedSprite2D.play("powerup")
	state = 1
	$CollisionShape2D.shape.set_deferred("size", Vector2(4, 12))
	$CollisionShape2D.position.y = 4

func power_down():
	is_moving = false
	is_animate = false
	$AnimatedSprite2D.play("powerup")
	state = 0
	$CollisionShape2D.shape.set_deferred("size", Vector2(4, 6))
	$CollisionShape2D.position.y = 10

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite2D.animation == "powerup":
		is_moving = true
		is_animate = true

func update_areas():
	var jump_pos_y = 0
	var jump_pos_x = 0
	if state > 0:
		jump_pos_y = -10
	if direction < 0:
		jump_pos_x = 0
		
	$JumpPointArea.get_node("CollisionShape2D").position.y = jump_pos_y
	$JumpPointArea.get_node("CollisionShape2D").position.x = jump_pos_x

func add_score(added_score):
	score += added_score
	emit_signal("score_changed", score)
	
func add_coin(added_coins):
	coins += added_coins
	emit_signal("coins_changed", coins)
	
# Hurt and dead
func hurt():
	if is_hurted:
		pass
	
	match state:
		0:
			is_hurted = true
			kill()
		1:
			is_hurted = true
			power_down()
			await $AnimatedSprite2D.animation_finished
			$AnimationPlayer.play("Flash")
			await get_tree().create_timer(2.0).timeout
			$AnimationPlayer.stop(true)
			$AnimatedSprite2D.visible = true
			is_hurted = false

func kill():
	is_moving = false
	is_animate = false
	$AnimationPlayer.play("Dead")
	await $AnimationPlayer.animation_finished
	emit_signal("dead")
	queue_free()
