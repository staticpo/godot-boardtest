extends KinematicBody2D

var velocity = Vector2(1, 0)
var speed = 300

func _physics_process(delta):
	var collisionInfo = move_and_collide(velocity.normalized() * speed * delta)
	
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
