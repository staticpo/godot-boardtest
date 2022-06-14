extends Node2D
const BulletPath = preload("res://scenes/Bullet.tscn")

export(int) var MaxHP = 100
export(int) var MaxArmor = 0
export(int) var MinDamage
export(int) var MaxDamage

export(int) var Armor = MaxArmor
export(int) var HP = MaxHP

func _on_Unit_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		shoot()


func shoot() -> void:
	print('shoottt')
	var bullet = BulletPath.instance()
	#get_parent().add_child(bullet)
	get_tree().get_root().add_child(bullet)
	bullet.position = $Position2D.global_position


func handleHit() -> void:
	$AnimationPlayer.play("hit")
	
func handleDeath() -> void:
	if HP <= 0:
		$AnimationPlayer.play("death")


func _on_Unit_body_entered(body):
	if body.is_in_group('bullets'):
		body.queue_free()
		handleHit()
