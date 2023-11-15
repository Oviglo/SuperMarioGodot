extends StaticBody2D

@onready var animatedCoin = preload("res://scene/entity/AnimatedCoin.tscn")
@onready var mushroom = preload("res://scene/entity/Mushroom.tscn")

@onready var wallParticle = preload("res://scene/entity/WallParticle.tscn")

var is_jumping = false

const BONUS_COIN = 0
const BONUS_MUSHROOM = 1
const BONUS_FLOWER = 2
const BONUS_EMPTY = 3

const TYPE_BONUS = 0
const TYPE_WALL = 1


@export var bonus: int = 0
@export var type: int = 0
@export_range(0, 10) var count: int = 1

signal add_coin

func _ready():
	match type:
		TYPE_BONUS:
			$Sprite2D.play("bonus")
		TYPE_WALL:
			$Sprite2D.play("wall")

func _on_ActiveArea_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.name == "JumpPointArea":
		var player = area.get_parent()
		var tween = get_tree().create_tween().bind_node(self)
		tween.set_ease(Tween.EASE_IN)
		
		if (player.is_jumping and !is_jumping and $Sprite2D.animation != "actived"):
			# if player is not small and bloc is an empty wall
			if type == TYPE_WALL and bonus == BONUS_EMPTY and player.state > 0:
				destroy()
				
			is_jumping = true
			tween.tween_property($Sprite2D, "position", Vector2(0, -8), 0.1)
			await tween.finished
			
			if count == 1 and bonus != BONUS_EMPTY:
				$Sprite2D.play("actived")
			
			tween.tween_property($Sprite2D, "position", Vector2(0, 8), 0.1)
			await tween.finished
			
			if count > 0:
				load_bonus()
				count -= 1
			is_jumping = false

func load_bonus():
	if bonus == BONUS_COIN:
		var item = animatedCoin.instantiate()
		item.position.y -= 16
		item.position.x -= 2
		add_child(item)
		emit_signal("add_coin")
	if bonus == BONUS_MUSHROOM:
		var item = mushroom.instantiate()
		item.position.y -= 16
		item.position.x = 8
		item.appear()
		item.connect('collect', Callable(self.get_parent(), "_on_Mushroom_collect"))
		add_child(item)

func destroy():
	$Sprite2D.hide()
	var particle1 = wallParticle.instantiate()
	particle1.position.x = position.x + 10
	particle1.position.y = position.y
	get_parent().call_deferred("add_child", particle1);
	particle1.apply_impulse(Vector2(48, -92), Vector2(1, 1))
	
	var particle2 = wallParticle.instantiate()
	particle2.position.x = position.x + 10
	particle2.position.y = position.y + 10
	get_parent().call_deferred("add_child", particle2);
	particle2.apply_impulse(Vector2(48, -64), Vector2(1, 1))
	
	var particle3= wallParticle.instantiate()
	particle3.position.x = position.x
	particle3.position.y = position.y
	get_parent().call_deferred("add_child", particle3);
	particle3.apply_impulse(Vector2(-48, -92), Vector2(1, 1))
	
	var particle4 = wallParticle.instantiate()
	particle4.position.x = position.x
	particle4.position.y = position.y + 10
	get_parent().call_deferred("add_child", particle4);
	particle4.apply_impulse(Vector2(-48, -64), Vector2(1, 1))
	
	queue_free()
