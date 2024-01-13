extends CharacterBody3D
class_name Patron

@export var adapter_type: Charger.adapter_type
@export var voltage_type: Table.voltage_type
@export var load_per_sec: float = 1.0
@export var max_charge: float

const SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction:= Vector3.ZERO
var navigation_target: Node3D
var level_manager: LevelManager
var canMove: bool = false

@onready var nav_agent: NavigationAgent3D = %nav_agent
@onready var current_charge: float = 0

func _ready():
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	if nav_agent.target_position:
		var next_positon = nav_agent.get_next_path_position()
		direction = global_position.direction_to(next_positon)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		look_at_target(direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if canMove:
		move_and_slide()

func register_level_manager(new_level_manager: LevelManager):
	level_manager = new_level_manager

func set_navigation_target(nav_target: Vector3):
	print_debug(nav_target)
	nav_agent.target_position = nav_target
	
func look_at_target(direction: Vector3):
	var adjusted_direction = direction
	adjusted_direction.y = 0
	
	look_at(global_position + adjusted_direction, Vector3.UP, false)
