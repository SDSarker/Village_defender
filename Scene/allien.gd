extends CharacterBody2D
var alive=1
@onready var timer: Timer = $Timer  # Make sure Timer is correctly referenced
var speed = 50
var direction: Vector2 = Vector2.ZERO  # Define the direction of movement
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if direction.x == 0:
		animated_sprite_2d.play("back")
	else:
		animated_sprite_2d.play("side")

func _process(delta):
	# Move the alien in the defined direction
	global_position += direction * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()  # Remove the alien when it exits the screen

func _on_alien_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && alive==1:  # Assuming player is in a "player" group
		animated_sprite_2d.play("blast")
		alive=0
		timer.start()  # Start the timer after the collision

func _on_timer_timeout() -> void:
	queue_free()  # Remove the alien after the timer ends
