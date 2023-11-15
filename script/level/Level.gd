extends "res://script/level/Game.gd"

@onready var coin = preload("res://scene/entity/Coin.tscn")
@onready var bonusBlock = preload("res://scene/entity/BonusBloc.tscn")
@onready var goomba = preload("res://scene/entity/Goomba.tscn")
@onready var koopaGreen = preload("res://scene/entity/KoopaGreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_entities()
	$Entities.hide()
	$Player.connect("dead", Callable(self, "on_player_dead"))

# Initialisation of entities
func init_entities():
	for cell in $Entities.get_used_cells(0):
		var id = $Entities.get_cell_source_id(0, cell)
		var pos = $Entities.map_to_local(cell)
		
		var entity = null
		match id:
			0: # Coin
				entity = coin.instantiate()
				entity.connect("collect", Callable(self, "on_Coin_collect"))
				
			1: # BonusCoin
				entity = bonusBlock.instantiate()
				entity.bonus = entity.BONUS_COIN
				entity.connect("add_coin", Callable(self, "on_Coin_collect"))
			
			"BonusCoin10":
				entity = bonusBlock.instantiate()
				entity.bonus = entity.BONUS_COIN
				entity.count = 10
				entity.connect("add_coin", Callable(self, "on_Coin_collect"))
			
			"BonusMushroom":
				entity = bonusBlock.instantiate()
				entity.bonus = entity.BONUS_MUSHROOM
				
			"Wall":
				entity = bonusBlock.instantiate()
				entity.bonus = entity.BONUS_EMPTY
				entity.type = entity.TYPE_WALL
				entity.count = 0
				
			"Goomba":
				entity = goomba.instantiate()
				
				entity.connect("hurt", Callable(self, "on_hurting"))
				
			"KoopaGreen":
				entity = koopaGreen.instantiate()
				entity.connect("hurt", Callable(self, "on_hurting"))
				
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
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scene/level/WorldIntro.tscn")
