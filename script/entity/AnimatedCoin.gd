extends AnimatedSprite

var is_animate = true

func _init():
	play("default")

func _process(delta):
	if is_animate:
		position.y -= 2

func _on_AnimatedCoin_animation_finished():
	queue_free()

func _on_AnimatedCoin_frame_changed():
	if frame == 4:
		is_animate = false
