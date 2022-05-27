extends Node2D
signal update_label

func updateLabel(text: String) -> void:
	$HUD/Label.text = text
