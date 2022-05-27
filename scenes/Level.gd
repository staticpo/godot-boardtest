extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Redraw_Button_pressed():
	$BoardTile.resetTile()


func _on_BlinkButton_pressed():
	$BoardTile.startBlinking()


func _on_BlinkStopButton_pressed():
	$BoardTile.stopBlinking()
