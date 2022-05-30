extends Node

#############################
#	Actions and Board info
#############################
enum actionId { HOVER }
enum boardEffectAreasId { SINGLE, CROSS, X, HORIZONTAL, VERTICAL, ALL_AROUND }
enum relativePosId { CURRENT, UP, UP_RIGHT, RIGHT, DOWN_RIGHT, DOWN, DOWN_LEFT, LEFT, UP_LEFT }

const relativeBoardPositions: Dictionary = {
	relativePosId.CURRENT : Vector2.ZERO,
	relativePosId.LEFT : Vector2(-1, 0),
	relativePosId.UP : Vector2(0, -1),
	relativePosId.RIGHT : Vector2(1, 0),
	relativePosId.DOWN : Vector2(0, 1),
	relativePosId.DOWN_LEFT : Vector2(-1, 1),
	relativePosId.DOWN_RIGHT : Vector2(1, 1),
	relativePosId.UP_RIGHT : Vector2(1, -1),
	relativePosId.UP_LEFT : Vector2(-1, -1),
}

const boardEffectAreas : Dictionary = {
	boardEffectAreasId.SINGLE: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP],
	],
	boardEffectAreasId.CROSS: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP],
		relativeBoardPositions[relativePosId.LEFT],
		relativeBoardPositions[relativePosId.DOWN],
		relativeBoardPositions[relativePosId.RIGHT],
	],
	boardEffectAreasId.X: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP_RIGHT],
		relativeBoardPositions[relativePosId.UP_LEFT],
		relativeBoardPositions[relativePosId.DOWN_RIGHT],
		relativeBoardPositions[relativePosId.DOWN_LEFT],
	],
	boardEffectAreasId.HORIZONTAL: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.LEFT],
		relativeBoardPositions[relativePosId.RIGHT],
	],
	boardEffectAreasId.VERTICAL: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP],
		relativeBoardPositions[relativePosId.DOWN],
	],
	boardEffectAreasId.ALL_AROUND: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP],
		relativeBoardPositions[relativePosId.LEFT],
		relativeBoardPositions[relativePosId.DOWN],
		relativeBoardPositions[relativePosId.RIGHT],
		relativeBoardPositions[relativePosId.UP_RIGHT],
		relativeBoardPositions[relativePosId.DOWN_RIGHT],
		relativeBoardPositions[relativePosId.DOWN_LEFT],
		relativeBoardPositions[relativePosId.UP_LEFT],
	],
}

var currentAction : Dictionary = {
	'action': actionId.HOVER,
	'type': boardEffectAreasId.VERTICAL,
}


func getCurrentAction() -> Dictionary:
	var response = {
		'action': currentAction.action,
		'type': currentAction.type,
		'params': boardEffectAreas[currentAction.type],
	}
	return response
