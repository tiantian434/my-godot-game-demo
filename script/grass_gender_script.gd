extends TileMapLayer

const GRASS = preload("uid://bm25j3rn7kvk1")
const OFFSET = 10

func _ready() -> void:
	enabled = false
	
	var cellArray = get_used_cells()
	for cellCoodinate in cellArray:
		var newGrass = GRASS.instantiate()
		newGrass.global_position =  global_position + cellCoodinate * 32.0 + Vector2(16.0,16.0)
		get_parent().add_child.call_deferred(newGrass)
		
		var radomOffset = Vector2(randf_range(-OFFSET,OFFSET),randf_range(-OFFSET,OFFSET))
		newGrass.global_position += radomOffset
		
		newGrass.get_node("Sprite2D").flip_h = randi_range(0,1)
		(newGrass.get_node("Sprite2D_back") as Sprite2D).flip_h = randi_range(0,1)
