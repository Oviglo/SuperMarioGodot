extends PlayerState

func enter(_msg: = {}) -> void:
	player._animated_sprite.play("Jump")

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.velocity.y = player.jump_speed
	else:
		state_machine.transition_to("Fall")
	
	player.move_and_slide()
