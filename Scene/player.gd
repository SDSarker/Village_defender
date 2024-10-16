extends CharacterBody2D


@onready var animation_player = $AnimationPlayer
var speed = 150
var isAttaking = false

func handleInput():
	var moveDirection = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("attack"):
		$Node2D.visible = true
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
func _physics_process(_delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	


func _on_area_2d_area_entered(_area: Area2D) -> void:
	print("Collided!")


func _on_sword_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		print("worked")
		
		


func _on_animation_player_animation_finished(attack) -> void:
	$Node2D.visible = false
