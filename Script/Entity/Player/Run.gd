extends PlayerState

func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, get_direction() * player.run_speed, player.acceleration)
	player.velocity.y += player.gravity * delta
	
	set_sprite_direction()

	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	
	if Input.is_action_just_released("run"):
		state_machine.transition_to("Walk")
	
	if is_equal_approx(get_direction(), 0.0):
		state_machine.transition_to("Idle")
