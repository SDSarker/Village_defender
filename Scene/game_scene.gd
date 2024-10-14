extends Node2D

# Load the alien scene
var alien_scene: PackedScene = preload("res://Scene//allien.tscn")

# Array to hold Marker2D positions
var markers: Array = []

# Timer to spawn aliens
var spawn_timer: Timer

func _ready():
	# Populate the markers array with the 7 Marker2D nodes
	for i in range(7):
		var marker = get_node_or_null(NodePath("Marker2D_" + str(i+1)))  # Properly create a NodePath
  # Use get_node_or_null to prevent errors
		if marker:  # Ensure marker exists
			markers.append(marker)
		else:
			print("Marker2D_", i + 1, " not found!")  # Debugging if a Marker2D is missing
	
	if markers.size() == 0:
		print("No Marker2D nodes found, check your scene structure.")
	
	# Set up the timer for spawning every 2 seconds
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 2.0
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)

# Function called every time the timer times out
func _on_spawn_timer_timeout():
	if markers.size() > 0:
		# Pick a random marker
		var random_marker = markers[randi() % markers.size()]
		
		# Spawn an alien at the random marker's position
		var alien_instance = alien_scene.instantiate()  # Instantiate the alien scene
		alien_instance.position = random_marker.position  # Set alien position to marker position
		add_child(alien_instance)
	else:
		print("No markers to spawn aliens at.")
