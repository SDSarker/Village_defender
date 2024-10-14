extends CharacterBody2D


@onready var animation_player = $AnimationPlayer
var speed = 150
var isAttaking = false

func handleInput():
	var moveDirection = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("attack"):
		animation_player.play("attack")
		isAttaking = true
		await animation_player.animation_finished
		isAttaking = false
		
func updateAnimation():
	if isAttaking: return
	
	if velocity.length() == 0:
		animation_player.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
	
		animation_player.play("walk" + direction)
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	
