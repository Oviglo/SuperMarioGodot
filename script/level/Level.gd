extends Node2D

onready var coin = preload("res://scene/entity/Coin.tscn")
onready var bonusBlock = preload("res://scene/entity/BonusBloc.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_entities()
	$Entities.hide()

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
				entity.type = entity.BONUS_COIN
			
			"BonusCoin10":
				entity = bonusBlock.instance()
				entity.type = entity.BONUS_COIN
				entity.count = 10
			
			"BonusMushroom":
				entity = bonusBlock.instance()
				entity.type = entity.BONUS_MUSHROOM
				
				
		if (entity != null):
			entity.position = pos
			add_child(entity)

func on_Coin_collect():
	print("Coin collect")

func _on_Mushroom_collect():
	print("got Mushroom")
	$Player.power_up()
