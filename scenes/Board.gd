extends Node2D

var currentTilePos : Vector2
export(int) var maxWidth
export(int) var maxHeight
export(PackedScene) var unit = preload("res://scenes/Unit.tscn")

export(int) var horizontalOffset = 10

func _on_Area2D_input_event(viewport, event, shape_idx):
	print('--------------------')
	var mpos = $TileMap.world_to_map(get_local_mouse_position())
	print(mpos)
	updateLabel(String(mpos))
	
	if isWithinBoundaries(mpos):
		#resetting the old cell to it's normal state
		if currentTilePos != null:
			$TileMap.set_cell(currentTilePos.x, currentTilePos.y, 4)
		#set the new cell to the selected color
		$TileMap.set_cell(mpos.x, mpos.y, 5)
		currentTilePos = mpos
		
	if Input.is_action_just_pressed("left_click") && isWithinBoundaries(currentTilePos):
		print('left clikc')
		var e = unit.instance()
		
		#var mtwPos = $TileMap.map_to_world(mpos)
		var mtwPos = $TileMap.map_to_world(mpos)
		
		var horizontalScale = $TileMap.scale.x
		e.position = Vector2(mtwPos.x + (horizontalOffset * horizontalScale), mtwPos.y)
		$TileMap.add_child(e)

func updateLabel(text: String) -> void:
	get_parent().emit_signal('update_label', text)
	
func isWithinBoundaries(pos: Vector2) -> bool:
	return pos.x < maxWidth && pos.y < maxHeight


func _on_Area2D_mouse_exited():
	# if it has a current cell, reset it
	if currentTilePos != null:
		$TileMap.set_cell(currentTilePos.x, currentTilePos.y, 4)
		
