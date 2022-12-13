tool
extends Node
class_name TileMapFiller

export (bool) var fill_tiles := false setget _fill_tile_map
export(Vector2) var fill_size := Vector2.ZERO
export(Vector2) var fill_offset := Vector2.ZERO


func _fill_tile_map(value):
	fill_tiles = false
	if not value:
		return
	
	var tile_map := get_parent() as TileMap
	
	if tile_map == null:
		print("Tilemap not found!")
		return
	
	tile_map.clear()
	for x in range(fill_size.x):
		for y in range(fill_size.y):
			tile_map.set_cell(x + int(fill_offset.x), y + int(fill_offset.y), (x+y)%2 )
	print(tile_map.name, " is filled!")
	pass
