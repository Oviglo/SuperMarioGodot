extends StaticBody2D

onready var animatedCoin = preload("res://scene/entity/AnimatedCoin.tscn")
onready var mushroom = preload("res://scene/entity/Mushroom.tscn")

var is_jumping = false

const BONUS_COIN = 0
const BONUS_MUSHROOM = 1
const BONUS_FLOWER = 2

export (int, "Coin", "Mushroom", "Flower") var type = 0
export (int, 0, 10) var count = 1

func _on_ActiveArea_body_entered(body):
	if (body.name == "Player"):
		if (body.is_jumping and !is_jumping):
			is_jumping = true
			if count > 1:
				$AnimationPlayer.play("jump")
			elif count == 1:
				$AnimationPlayer.play("active")

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "jump"):
		is_jumping = false
		count -= 1
		
	load_bonus()

func load_bonus():
	if type == BONUS_COIN:
		var bonus = animatedCoin.instance()
		bonus.position.y -= 16
		bonus.position.x -= 2
		add_child(bonus)
	if type == BONUS_MUSHROOM:
		var bonus = mushroom.instance()
		bonus.position.y -= 16
		bonus.appear()
		add_child(bonus)
