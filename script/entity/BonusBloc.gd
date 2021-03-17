extends StaticBody2D

onready var animatedCoin = preload("res://scene/entity/AnimatedCoin.tscn")
onready var mushroom = preload("res://scene/entity/Mushroom.tscn")

onready var wallParticle = preload("res://scene/entity/WallParticle.tscn")

var is_jumping = false

const BONUS_COIN = 0
const BONUS_MUSHROOM = 1
const BONUS_FLOWER = 2
const BONUS_EMPTY = 3

const TYPE_BONUS = 0
const TYPE_WALL = 1


export (int, "Coin", "Mushroom", "Flower", "Empty") var bonus = 0
export (int, "Bonus", "Wall") var type = 0
export (int, 0, 10) var count = 1

func _ready():
	match type:
		TYPE_BONUS:
			$Sprite.play("bonus")
		TYPE_WALL:
			$Sprite.play("wall")

func _on_ActiveArea_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.name == "JumpPointArea":
		var player = area.get_parent()
		if (player.is_jumping and !is_jumping and $Sprite.animation != "actived"):
			# if player is not small and bloc is an empty wall
			if type == TYPE_WALL and bonus == BONUS_EMPTY and player.state > 0:
				destroy()
				
			is_jumping = true
			$Tween.interpolate_property($Sprite, "position", Vector2(0, 0), Vector2(0, -8), 0.1, Tween.EASE_IN, Tween.EASE_IN)
			$Tween.start()
			yield($Tween, "tween_completed")
			
			if count == 1 and bonus != BONUS_EMPTY:
				$Sprite.play("actived")
			$Tween.interpolate_property($Sprite, "position", Vector2(0, -8), Vector2(0, 0), 0.1, Tween.EASE_OUT, Tween.EASE_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			
			if count > 0:
				load_bonus()
				count -= 1
			is_jumping = false

func load_bonus():
	if bonus == BONUS_COIN:
		var item = animatedCoin.instance()
		item.position.y -= 16
		item.position.x -= 2
		add_child(item)
	if bonus == BONUS_MUSHROOM:
		var item = mushroom.instance()
		item.position.y -= 16
		item.position.x = 8
		item.appear()
		item.connect('collect', self.get_parent(), "_on_Mushroom_collect")
		add_child(item)

func destroy():
	$Sprite.hide()
	var particle1 = wallParticle.instance()
	particle1.position.x = position.x + 10
	particle1.position.y = position.y
	get_parent().add_child(particle1)
	particle1.apply_impulse(Vector2(1, 1), Vector2(48, -92))
	
	var particle2 = wallParticle.instance()
	particle2.position.x = position.x + 10
	particle2.position.y = position.y + 10
	get_parent().add_child(particle2)
	particle2.apply_impulse(Vector2(1, 1), Vector2(48, -64))
	
	var particle3= wallParticle.instance()
	particle3.position.x = position.x
	particle3.position.y = position.y
	get_parent().add_child(particle3)
	particle3.apply_impulse(Vector2(1, 1), Vector2(-48, -92))
	
	var particle4 = wallParticle.instance()
	particle4.position.x = position.x
	particle4.position.y = position.y + 10
	get_parent().add_child(particle4)
	particle4.apply_impulse(Vector2(1, 1), Vector2(-48, -64))
	
	queue_free()
