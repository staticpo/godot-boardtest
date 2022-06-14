extends Node2D
signal update_label
signal update_label_mouse_pos
signal update_label3

func updateLabel(text: String) -> void:
	$HUD/Label.text = text

func updateLabelMousePosition(text: String) -> void:
	$HUD/MousePos.text = text
	
func updateLabel3(text: String) -> void:
	$HUD/Label3.text = text


func _on_DangerButton_pressed():
	G.setCurrentAction(G.actionId.ATTACK, G.actionTypeId.X)

func _on_HoverButton_pressed():
	G.setCurrentAction(G.actionId.HOVER, G.actionTypeId.SINGLE)
	
func _on_BonusButton_pressed():
	G.setCurrentAction(G.actionId.BONUS, G.actionTypeId.CROSS)
