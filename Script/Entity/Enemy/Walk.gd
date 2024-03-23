extends EnemyState

func enter(_msg: = {}) -> void:
	pass

func physics_update(delta: float) -> void:
	enemy.velocity.x = lerp(enemy.velocity.x, 1.0 * enemy.direction * enemy.speed, 1)
	enemy.velocity.y += enemy.gravity * delta
	
	if enemy.is_on_wall():
		enemy.direction *= -1
		
	enemy.move_and_slide()
