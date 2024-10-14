extends CharacterBody2D

var speed = 50


func _process(delta):
	global_position.x -= speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	print("dead")
	queue_free()
