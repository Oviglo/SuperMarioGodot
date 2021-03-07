extends Node2D

onready var coin = preload("res://scene/entity/Coin.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	init_entities()
	$Entities.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Initialisation of entities
func init_entities():
	for cell in $Entities.get_used_cells():
		var id = $Entities.get_cellv(cell)
		var type = $Entities.get_cell(cell.x, cell.y)
		var pos = $Entities.map_to_world(cell)
		
		match type: # Coin
			0:
				var entity = coin.instance()
				entity.position = pos
				add_child(entity)
