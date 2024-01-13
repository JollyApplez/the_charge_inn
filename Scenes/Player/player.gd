extends CharacterBody3D


const SPEED = 5.0

@onready var camera_3d: Camera3D = %Camera3D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var rotation_speed := 5

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var modified_direction = camera_3d._get_mouse_position()
	modified_direction.y = position.y
	if global_position.distance_to(modified_direction) > 1.5:
		look_at(modified_direction)
	
		if direction: #and global_position.distance_to(modified_direction) > 2:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		
	if !direction:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	


	
	move_and_slide()

