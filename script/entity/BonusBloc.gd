extends StaticBody2D

var is_jumping = false
var jump_animation = 0

const TYPE_COIN = 0
const TYPE_COIN_10 = 1

export (int, "Coin", "Coinx10") var type = 0;


func _on_ActiveArea_body_entered(body):
	if (body.name == "Player"):
		if (body.is_jumping and !is_jumping):
			is_jumping = true
			$AnimationPlayer.play("jump")
