extends "res://script/level/Game.gd"

onready var coin = preload("res://scene/entity/Coin.tscn")
onready var bonusBlock = preload("res://scene/entity/BonusBloc.tscn")
onready var goomba = preload("res://scene/entity/Goomba.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_entities()
	$Entities.hide()
	$Player.connect("dead", self, "on_player_dead")

# Initialisation of entities
func init_entities():
	for cell in $Entities.get_used_cells():
		var id = $Entities.get_cellv(cell)
		var pos = $Entities.map_to_world(cell)
		var name = $Entities.tile_set.tile_get_name(id)
		
		var entity = null
		match name:
			"Coin":
				entity = coin.instance()
				entity.connect("collect", self, "on_Coin_collect")
				
			"BonusCoin":
				entity = bonusBlock.instance()
				entity.bonus = entity.BONUS_COIN
				entity.connect("add_coin", self, "on_Coin_collect")
			
			"BonusCoin10":
				entity = bonusBlock.instance()
				entity.bonus = entity.BONUS_COIN
				entity.count = 10
				entity.connect("add_coin", self, "on_Coin_collect")
			
			"BonusMushroom":
				entity = bonusBlock.instance()
				entity.bonus = entity.BONUS_MUSHROOM
				
			"Wall":
				entity = bonusBlock.instance()
				entity.bonus = entity.BONUS_EMPTY
				entity.type = entity.TYPE_WALL
				entity.count = 0
				
			"Goomba":
				entity = goomba.instance()
				
				entity.connect("hurt", self, "on_hurting")
				
		if (entity != null):
			entity.position = pos
			add_child(entity)

func on_Coin_collect():
	$Player.add_coin(1)
	$Player.add_score(100)

func _on_Mushroom_collect():
	$Player.power_up()
	
func on_hurting(node):
	if node.name == "Player":
		$Player.hurt()

func on_player_dead():
	life -= 1
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://scene/level/WorldIntro.tscn")
