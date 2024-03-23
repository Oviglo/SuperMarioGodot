class_name  Enemy
extends MovingEntity

@onready var _animated_sprite := $AnimatedSprite2D
@onready var _wall_collision := $WallCollision

func _ready() -> void:
	_animated_sprite.play("walk")
