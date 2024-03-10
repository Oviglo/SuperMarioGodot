extends Game

@onready var entities: TileMap = $Entities
@onready var goomba = preload("res://Scene/Entity/Enemy/goomba.tscn")

func _ready() -> void:
	entities.hide()
	init_entities()

func init_entities() -> void:
	for cell in entities.get_used_cells(0):
		var data:TileData = entities.get_cell_tile_data(0, cell) 
		var position: Vector2 = entities.map_to_local(cell)
		var name: String = data.get_custom_data("name")
		
		var entity: Node = null
		match name:
			"goomba":
				entity = goomba.instantiate()
				
		if entity != null:
			entity.position = position
			add_child(entity)			
	pass
