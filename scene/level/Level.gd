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
		var type = $Entities.get_cell(cell.x, cell.y)
		var pos = $Entities.map_to_world(cell)
		
		print(type)
		
		var entity = null
		match type:
			0: # Coin
				entity = coin.instance()
				entity.position = pos
				entity.connect("collect", self, "on_coin_collect")
				
			1: # Coin Bonus bloc
				entity = bonusBlock.instance()
				entity.position = pos
				entity.type = entity.TYPE_COIN
				
		if (entity != null):
			add_child(entity)

func on_coin_collect():
	print("Coin collect")
