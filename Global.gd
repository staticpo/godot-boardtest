extends Node

#############################
#	Actions and Board info
#############################
enum actionId { NONE, HOVER, ATTACK, BONUS }
enum actionTypeId { 
	SINGLE,
	CROSS,
	X,
	HORIZONTAL,
	VERTICAL,
	ALL_AROUND,
	SLASH,
	INVERTED_SLASH
}

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
	actionTypeId.SINGLE: [
		relativeBoardPositions[relativePosId.CURRENT],
	],
	actionTypeId.CROSS: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP],
		relativeBoardPositions[relativePosId.LEFT],
		relativeBoardPositions[relativePosId.DOWN],
		relativeBoardPositions[relativePosId.RIGHT],
	],
	actionTypeId.X: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP_RIGHT],
		relativeBoardPositions[relativePosId.UP_LEFT],
		relativeBoardPositions[relativePosId.DOWN_RIGHT],
		relativeBoardPositions[relativePosId.DOWN_LEFT],
	],
	actionTypeId.SLASH: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP_RIGHT],
		relativeBoardPositions[relativePosId.DOWN_LEFT],
	],
	actionTypeId.INVERTED_SLASH: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP_LEFT],
		relativeBoardPositions[relativePosId.DOWN_RIGHT],
	],
	actionTypeId.HORIZONTAL: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.LEFT],
		relativeBoardPositions[relativePosId.RIGHT],
	],
	actionTypeId.VERTICAL: [
		relativeBoardPositions[relativePosId.CURRENT],
		relativeBoardPositions[relativePosId.UP],
		relativeBoardPositions[relativePosId.DOWN],
	],
	actionTypeId.ALL_AROUND: [
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
	'type': actionTypeId.SINGLE,
} setget , getCurrentAction

#############################
#	Units
#############################
## Contains info for each unit
var unitsData 

#############################
#	Misc
#############################
enum teams { EIGHTIES, FUTURE }
## Contains info for each unit
var unitsData1

#############################
#	Setters and Getters
#############################
func getCurrentAction() -> Dictionary:
	var response = {
		'action': currentAction.action,
		'type': currentAction.type,
		'params': boardEffectAreas[currentAction.type],
	}
	return response
	
func setCurrentAction(newActionId, newActionType) -> void:
	currentAction = {
		'action': newActionId,
		'type': newActionType,
	}
	
#############################
#	Methods
#############################

func _ready():
	var unitsFile = File.new()
	unitsFile.open("res://data/units.json", File.READ)
	var unitsJSON = JSON.parse(unitsFile.get_as_text())
	unitsFile.close()
	unitsData1 = unitsJSON.result
	
	print(unitsData1["cyborg"])
	print(unitsData1["policeman"])
