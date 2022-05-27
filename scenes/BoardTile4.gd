extends Node2D

var currentTilePos : Vector2



func _on_Area2D_input_event(viewport, event, shape_idx):
	print('--------------------')
	var mpos = $TileMap.world_to_map(get_local_mouse_position())
	print(mpos)
	if currentTilePos:
		$TileMap.set_cell(currentTilePos.x, currentTilePos.y, 2)
	$TileMap.set_cell(mpos.x, mpos.y, 3)
	currentTilePos = mpos

