extends Node2D

var currentTilePos
export(int) var maxWidth
export(int) var maxHeight

const WARNING_TEXTURE_INDEX = 4
const DANGER_TEXTURE_INDEX = 7
const NORMAL_TEXTURE_INDEX = 5
const EMPTY_TEXTURE_INDEX = -1



export(PackedScene) var unit = preload("res://scenes/Unit.tscn")
export(int) var horizontalOffset = 10

func _on_Area2D_input_event(viewport, event, shape_idx):
	var mpos = $TileMap.world_to_map(get_local_mouse_position())
	updateLabel(String(mpos))
	
	if isWithinBoundaries(mpos):
		handleHover(mpos)
		
	if Input.is_action_just_pressed("left_click") && isWithinBoundaries(currentTilePos):
		print('left clikc')
		var e = unit.instance()
		
		#var mtwPos = $TileMap.map_to_world(mpos)
		var mtwPos = $TileMap.map_to_world(mpos)
		
		var horizontalScale = $TileMap.scale.x
		e.z_index = 1
		e.position = Vector2(mtwPos.x + (horizontalOffset * horizontalScale), mtwPos.y)
		$TileMap.add_child(e)

func updateLabel(text: String) -> void:
	get_parent().emit_signal('update_label', text)
	
func isWithinBoundaries(pos: Vector2) -> bool:
	return pos.x < maxWidth && pos.y < maxHeight && pos.x >= 0 && pos.y >= 0

func handleHover(pos: Vector2):
	var currentAction = G.getCurrentAction()
	if currentAction['action'] == G.actionId.HOVER:
		#first clear all cells
		$TileMapAbove.clear()
		currentTilePos = pos
		
		var cells = getCellsToModify(currentAction['params'])
		for cell in cells:
			$TileMapAbove.set_cellv(cell, WARNING_TEXTURE_INDEX)
		

func getCellsToModify(directions: PoolVector2Array) -> PoolVector2Array:
	var response: PoolVector2Array
	for direction in directions:
		if isWithinBoundaries(currentTilePos + direction):
			response.append(currentTilePos + direction)
	return response

func _on_Area2D_mouse_exited():
	$TileMapAbove.clear()
	currentTilePos = null
		
