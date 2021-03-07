extends StaticBody2D

onready var animatedCoin = preload("res://scene/entity/AnimatedCoin.tscn")

var is_jumping = false

const BONUS_COIN = 0

export (int, "Coin") var type = 0
export (int, 0, 10) var count = 1

func _on_ActiveArea_body_entered(body):
	if (body.name == "Player"):
		if (body.is_jumping and !is_jumping):
			is_jumping = true
			if count > 1:
				$AnimationPlayer.play("jump")
			elif count == 1:
				$AnimationPlayer.play("active")
				
			load_bonus()

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "jump"):
		is_jumping = false
		count -= 1

func load_bonus():
	if type == BONUS_COIN:
		var anim = animatedCoin.instance()
		anim.position.y -= 16
		anim.position.x -= 2
		add_child(anim)
