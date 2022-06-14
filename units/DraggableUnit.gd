extends Control

func get_drag_data(_pos):
	var preview = self.duplicate()
	# transparência
	preview.modulate.a = .5
	# centralizar ao mouse
	#preview.get_node("Sprite").rect_position = -self.rect_size / 2
	# esconde o fundo
	#preview.get_node("bkg").hide()

	set_drag_preview(preview)
	
	## jorge todo: Return an unit ID here
	return self
