extends CharacterBody2D

@export var speed: int = 90
@export var jump_speed = -300
@export var gravity: int = 600
@export_range(0.0, 1.0) var friction = 0.2
@export_range(0.0 , 1.0) var acceleration = 0.15

enum STATE_TYPE {
	IDLE,
	WALK,
	RUN,
	JUMP,
}

var state: int = STATE_TYPE.IDLE

func _physics_process(delta) -> void:
	
	velocity.y += gravity * delta
	
	var dir = Input.get_axis("walk_left", "walk_right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
