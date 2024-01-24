extends CharacterBody2D

@export var speed: int = 100
@export var gravity: int = 100
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

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
