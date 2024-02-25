class_name Player
extends CharacterBody2D

@onready var _animated_sprite := $AnimatedSprite2D

@export var walk_speed: int = 90
@export var jump_speed = -300
@export var run_speed: int = 150
@export var gravity: int = 600

## Friction between 0 and 1
@export_range(0.0, 1.0) var friction = 0.2
## Acceleration between 0 and 1
@export_range(0.0, 1.0) var acceleration = 0.1
