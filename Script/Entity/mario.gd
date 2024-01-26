extends CharacterBody2D

@onready var _animated_sprite := $AnimatedSprite2D

@export var walk_speed: int = 90
@export var jump_speed = -300
@export var run_speed: int = 130
@export var gravity: int = 600
@export_range(0.0, 1.0) var friction = 0.2
@export_range(0.0 , 1.0) var acceleration = 0.15

var speed: int = walk_speed
var movement_state: int = MOVEMENT_STATE.STOP
var direction: float = 1
var is_run: bool = false
var is_skid: bool = false

const RUN_ANIMATION_SCALE: float = 1.2

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
	SKID,
}

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
	
func run_start() -> void:
	is_run = true
	speed = run_speed
	
func run_stop() -> void:
	is_run = false
	speed = walk_speed
	
func run_animation_speed():
	if (is_run):
		_animated_sprite.set_speed_scale(RUN_ANIMATION_SCALE)
	else:
		_animated_sprite.set_speed_scale(1)	

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
				run_animation_speed()
			else:
				_animated_sprite.play("Jump")
		ANIMATION.SKID:
			if is_on_floor():
				_animated_sprite.play('Skid')
	
	generate_direction()
		
func generate_direction():
	if direction != 0 && is_on_floor():
		_animated_sprite.flip_h = direction < 0

# ===== CharacterBody2D functions =====
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
		
	if Input.is_action_just_pressed('run'):
		run_start()
		
	if Input.is_action_just_released('run'):
		run_stop()
