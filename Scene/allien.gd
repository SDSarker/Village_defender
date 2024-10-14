extends CharacterBody2D

var speed = 50
var direction: Vector2 = Vector2.ZERO  # Define the direction of movement

func _process(delta):
	# Move the alien in the defined direction
	global_position += direction * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()  # Remove the alien when it exits the screen
