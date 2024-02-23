extends PlayerState

func enter(_msg: = {}) -> void:
	player._animated_sprite.play("Walk")

func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, get_direction() * player.walk_speed, player.acceleration)
	player.velocity.y += player.gravity * delta
	
	if get_direction() != 0:
		player._animated_sprite.flip_h = get_direction() < 0
	
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	
	if is_equal_approx(get_direction(), 0.0):
		state_machine.transition_to("Idle")
