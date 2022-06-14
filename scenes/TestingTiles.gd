extends Node2D

const defaultColor = Color(255, 0, 0, 1)
const blinkColor1 = Color(0, 0, 255, 1)
const blinkColor2 = Color(0, 255, 0, 1)

func resetTile():
	$Parallelogram.color = defaultColor
	$Parallelogram.emit_signal("redraw")

func redrawTile():
	$Parallelogram.emit_signal("redraw")

func startBlinking():
	$BlinkTimer.start()

func stopBlinking():
	$BlinkTimer.stop()

func _on_BlinkTimer_timeout():
	if $Parallelogram.color == blinkColor1:
		$Parallelogram.color = blinkColor2
		$Parallelogram.emit_signal("redraw")
	else:
		$Parallelogram.color = blinkColor1
		$Parallelogram.emit_signal("redraw")


func _on_Anim1_pressed():
	$AnimationPlayer.play("danger")
