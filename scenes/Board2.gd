extends Node2D

var currentTilePos
export(int) var maxWidth
export(int) var maxHeight

const TEXTURE_INDEX_WARNING = 9
const TEXTURE_INDEX_DANGER = 10
const TEXTURE_INDEX_NORMAL = 4
const TEXTURE_INDEX_BONUS = 7
const TEXTURE_INDEX_HOVER = 8
const TEXTURE_INDEX_EMPTY = -1

## the vertices of a single cell from the tilemap
# const singleCellDimensions = PoolVector2Array([Vector2(-16, 18), Vector2(1, 1), Vector2(38, 1), Vector2(21, 18)])
const collisionShapeSize = Vector2(19, 19)
const collisionShapePosition = Vector2(20, 20)



export(PackedScene) var unitResource = preload("res://units/Unit.tscn")
export(int) var horizontalOffset = 20
export(int) var verticalOffset = 10

func _ready():
	# iterate all cells and set them with the 'normal' texture
	for i in maxWidth:
		for j in maxHeight:
			$TileMap.set_cell(i, j, TEXTURE_INDEX_NORMAL)
	
	var collisionRectangle = RectangleShape2D.new()
	collisionRectangle.extents = Vector2(collisionShapeSize.x * maxWidth + maxWidth - 1, collisionShapeSize.y * maxHeight + maxHeight - 1)
	
	$Area2D/CollisionShape2D.shape = collisionRectangle
	$Area2D/CollisionShape2D.position = Vector2(
		collisionShapePosition.x * maxWidth,
		collisionShapePosition.y * maxHeight + int(round(maxHeight / 2))
	)
	$Control.rect_position = Vector2(0, 0)
	$Control.rect_size = Vector2($TileMap.cell_size.x * maxWidth, $TileMap.cell_size.y * maxHeight)
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	get_parent().emit_signal('update_label_mouse_pos', String(get_global_mouse_position()))
	
	var mpos = $TileMap.world_to_map(get_local_mouse_position())
	updateLabel(String(mpos))
	
	if isWithinBoundaries(mpos):
		currentTilePos = mpos
		handleHover(currentTilePos)
		
	if Input.is_action_just_pressed("left_click") && isWithinBoundaries(mpos):
		print('left clikc')
		var unit = unitResource.instance()
		
		#var mtwPos = $TileMap.map_to_world(mpos)
		var mtwPos = $TileMap.map_to_world(mpos)
		print('mtwPos', mtwPos)
		
		var horizontalScale = $TileMap.scale.x
		var verticalScale = $TileMap.scale.y
		print('horizScale:', horizontalScale)

		unit.scale = global_scale * 0.75
		print('unitScale', unit.scale)
		# setting the z-pos equal to the row number, so the ones on bottom appear on top
		unit.z_index = mpos.y + 1
		unit.position = Vector2(mtwPos.x + (horizontalOffset * horizontalScale), mtwPos.y + (verticalOffset * verticalScale))
		print('unitPos', unit.position)
		$TileMap.add_child(unit)


func _on_Control_gui_input(event):
	get_parent().emit_signal('update_label_mouse_pos', String(get_global_mouse_position()))
	
	var mpos = $TileMap.world_to_map(get_local_mouse_position())
	updateLabel(String(mpos))
	
	if isWithinBoundaries(mpos):
		currentTilePos = mpos
		handleHover(currentTilePos)


func updateLabel(text: String) -> void:
	get_parent().emit_signal('update_label', text)
	
func isWithinBoundaries(pos: Vector2) -> bool:
	return pos.x < maxWidth && pos.y < maxHeight && pos.x >= 0 && pos.y >= 0

func handleHover(pos: Vector2):
	var currentAction = G.getCurrentAction()
	#first clear all cells
	$TileMapAbove.clear()
	currentTilePos = pos
	
	# define which texture to use for hovering
	var textureToUse = TEXTURE_INDEX_NORMAL
	match currentAction['action']:
		G.actionId.ATTACK:
			textureToUse = TEXTURE_INDEX_DANGER
		G.actionId.BONUS:
			textureToUse = TEXTURE_INDEX_BONUS
		G.actionId.HOVER:
			textureToUse = TEXTURE_INDEX_HOVER
		_:
			textureToUse = TEXTURE_INDEX_NORMAL

	var cells = getCellsToModify(currentAction['params'])
	for cell in cells:
		$TileMapAbove.set_cellv(cell, textureToUse)
		

func getCellsToModify(directions: PoolVector2Array) -> PoolVector2Array:
	var response: PoolVector2Array
	for direction in directions:
		if isWithinBoundaries(currentTilePos + direction):
			response.append(currentTilePos + direction)
	return response

func _on_Area2D_mouse_exited():
	$TileMapAbove.clear()
	currentTilePos = null

func _on_Control_mouse_exited():
	$TileMapAbove.clear()
	currentTilePos = null


