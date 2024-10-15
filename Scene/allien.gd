extends CharacterBody2D

@export var speed: float = 50  # Alien's movement speed
var direction: Vector2 = Vector2.ZERO  # Movement direction
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D  # Alien's animation

func _physics_process(delta: float) -> void:
	# Move the alien and handle sliding along walls
	velocity = direction * speed

	# Use move_and_slide for basic movement
	move_and_slide()

	# Check for collisions
	var collision = move_and_collide(velocity * delta)

	if collision:
		# If moving left and hit a wall, try sliding down to the nearest gap
		if direction == Vector2(-1, 0):
			direction = find_nearest_gap(Vector2(0, 1))  # Look for gaps downwards

		# If moving up and hit a wall, find the nearest gap left or right
		elif direction == Vector2(0, -1):
			direction = find_nearest_gap(Vector2(-1, 0), Vector2(1, 0))  # Check left and right

	# Update the animation based on the current direction
	update_animation()

# Check for the nearest gap (without walls) in the given directions
func find_nearest_gap(primary_direction: Vector2, secondary_direction: Vector2 = Vector2.ZERO) -> Vector2:
	# Check in small steps to find an open space
	var step_size = 10.0  # Step size to search for gaps
	var max_search_distance = 100.0  # Maximum distance to search for gaps
	var search_distance = 0.0

	# Check primary direction first (e.g., sliding down if moving left)
	while search_distance <= max_search_distance:
		var test_position = global_position + primary_direction * search_distance
		if is_open_at(test_position):
			return primary_direction  # Found a gap in the primary direction
		search_distance += step_size

	# If no gap found in the primary direction, check the secondary direction (left or right)
	search_distance = 0.0
	while search_distance <= max_search_distance and secondary_direction != Vector2.ZERO:
		var test_position_left = global_position + secondary_direction * search_distance
		if is_open_at(test_position_left):
			return secondary_direction  # Found a gap in the secondary direction
		search_distance += step_size

	# If no gaps found, return the current direction (keep moving forward)
	return primary_direction

# Check if there is no wall at the given position
func is_open_at(pos: Vector2) -> bool:
	# Create a PhysicsPointQueryParameters2D object to specify the query parameters
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos  # Set the position to check for collisions

	# Use the direct space state to perform the intersection check
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_point(query)

	# If there are no collisions at the position, return true (open space)
	


	# If there are no collisions at the position, return true (open space)
	return result.size() == 0


# Update the alien's animation based on the current direction
func update_animation() -> void:
	if direction == Vector2(0, -1):  # Moving up
		animated_sprite_2d.play("back")
	elif direction == Vector2(-1, 0) or direction == Vector2(1, 0):  # Moving left or right
		animated_sprite_2d.play("side")
