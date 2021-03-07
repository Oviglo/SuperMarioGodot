extends AnimatedSprite

signal collect

func _on_Area2D_body_entered(body):
	emit_signal("collect")
	queue_free()
