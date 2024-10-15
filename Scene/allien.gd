extends CharacterBody2D

var speed = 50
var direction: Vector2 = Vector2.ZERO  # Define the direction of movement
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if(direction.x==0):
		animated_sprite_2d.play("back")
	else:
		animated_sprite_2d.play("side")
func _process(delta):
	# Move the alien in the defined direction
	global_position += direction * speed * delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()  # Remove the alien when it exits the screen
func hit():
	pass
	
