extends CharacterBody3D
class_name Player

const BASE_SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var rotation_speed := 5
var speed = BASE_SPEED
var current_state: State
var interact_range := 5.0

@onready var camera_3d: Camera3D = %Camera3D

signal assigned_seat_signal(charger: Charger)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

func player_look(): 
	var modified_direction = camera_3d._get_mouse_position()
	modified_direction.y = position.y
	if global_position.distance_to(modified_direction) > 1.5:
		look_at(modified_direction)

func player_move():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var modified_direction = camera_3d._get_mouse_position()
	modified_direction.y = position.y
	if global_position.distance_to(modified_direction) > 1.5:
		look_at(modified_direction)
	
		if direction: #and global_position.distance_to(modified_direction) > 2:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		
	if !direction:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


func _on_state_machine_state_transition(new_state: State) -> void:
	current_state = new_state

func get_current_state() -> State:
	return current_state
