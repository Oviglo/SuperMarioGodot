extends PlayerState

func enter(_msg: = {}) -> void:
	owner.velocity = Vector2.ZERO
	player._animated_sprite.play("Idle")

func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
	if !player.is_on_floor():
		state_machine.transition_to("Fall")
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif is_walking():
		state_machine.transition_to("Walk")
