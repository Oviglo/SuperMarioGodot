extends CharacterBody2D

@onready var _animated_sprite := $AnimatedSprite2D

@export var speed: int = 90
@export var jump_speed = -300
@export var gravity: int = 600
@export_range(0.0, 1.0) var friction = 0.2
@export_range(0.0 , 1.0) var acceleration = 0.15

enum MOVEMENT_STATE {
	STOP,
	WALK,
	RUN,
	JUMP,
}

enum ANIMATION {
	IDLE,
	WALK,
	JUMP,
}

var movement_state: int = MOVEMENT_STATE.STOP
var direction: float = 1

func _physics_process(delta) -> void:
	
	velocity.y += gravity * delta
	
	direction = Input.get_axis("walk_left", "walk_right")
	if direction != 0:
		walk()
	else:
		stop()
	
	move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		jump()

func walk() -> void:
	velocity.x = lerp(velocity.x, direction * speed, acceleration)
	set_animation(ANIMATION.WALK)
	if is_on_floor():
		movement_state = MOVEMENT_STATE.WALK

func stop() -> void:
	velocity.x = lerp(velocity.x, 0.0, friction)
	set_animation(ANIMATION.IDLE)
	if is_on_floor():
		movement_state = MOVEMENT_STATE.STOP

func jump() -> void:
	if is_on_floor():
		velocity.y = jump_speed
		movement_state = MOVEMENT_STATE.JUMP

func set_animation(name: ANIMATION) -> void:
	match (name):
		ANIMATION.IDLE:
			if is_on_floor(): 
				_animated_sprite.play("Idle")
			else:
				_animated_sprite.play("Jump")
		ANIMATION.WALK:
			if is_on_floor(): 
				_animated_sprite.play("Walk")
			else:
				_animated_sprite.play("Jump")
	# Set direction	
	if direction != 0 and movement_state != MOVEMENT_STATE.JUMP:
		_animated_sprite.flip_h = direction < 0
