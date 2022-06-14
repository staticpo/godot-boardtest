extends Control

func _ready():
	randomize()
	
	# Set all children as MOUSE_FILTER_IGNORE
	# this enables drag & drop for some reason
	for n in get_children():
		if "mouse_filter" in n:
			n.mouse_filter = MOUSE_FILTER_IGNORE

func can_drop_data(_pos, data):
	var canDrop = data is Node
	print ('canDrop %s' % String(canDrop))
	return true

func drop_data(_pos, data):
	print('dropped --')
	print(data)
