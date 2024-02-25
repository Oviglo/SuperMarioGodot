class_name Fall
extends PlayerState

func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta

	# Brake the falling
	if (player.velocity.x * get_direction()) < 0:
		player.velocity.x += get_direction()
	
	player.move_and_slide()
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
