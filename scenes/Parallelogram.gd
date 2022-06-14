extends Node2D
signal redraw

export(Color) var color

#https://docs.godotengine.org/en/stable/tutorials/2d/custom_drawing_in_2d.html

func _draw():
	var points = PoolVector2Array()
	var colour = PoolColorArray()
	#points = [Vector2(150,100), Vector2(250,100), Vector2(200,200),Vector2(100,200)]
	#colour = [color, Color(0, 255, 0, 1), color, Color(0, 255, 0, 1)]
	#colour = [Color(0, 0, 0, 0)]
	#draw_polygon(points,colour)
	points = [Vector2(150,100), Vector2(250,100), Vector2(200,200),Vector2(100,200), Vector2(150,100)]
	draw_polyline(points, color, 1, false)

func redrawTile():
	update()
