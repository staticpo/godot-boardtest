tool
extends Polygon2D

export(Color) var OutLine = Color(0,0,0) setget set_color
export(float) var Width = 2.0 setget set_width

func _draw():
	var points = PoolVector2Array()
	var poly = get_polygon()
	for i in range(0 , poly.size()):
		#if i == poly.size():
		#	points.append(poly[0])
		#else:
		points.append(poly[i])
	points.append(poly[0])
		#draw_line(poly[i-1] , poly[i], OutLine , Width)
	#draw_line(poly[poly.size() - 1] , poly[0], OutLine , Width)
	
	draw_polyline(points, OutLine, Width, false)

#func _draw():
#	var poly = get_polygon()
#	for i in range(1 , poly.size()):
#		draw_line(poly[i-1] , poly[i], OutLine , Width)
#	draw_line(poly[poly.size() - 1] , poly[0], OutLine , Width)

func set_color(color):
	OutLine = color
	update()

func set_width(new_width):
	Width = new_width
	update()
