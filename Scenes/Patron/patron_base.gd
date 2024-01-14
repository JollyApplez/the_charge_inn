extends CharacterBody3D
class_name Patron

@export var adapter_type: Charger.adapter_type
@export var voltage_type: Table.voltage_type
@export var load_per_sec: float = 1.0
@export var max_charge: float
@export var anim_player: AnimationPlayer

const SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction:= Vector3.ZERO
var level_manager: LevelManager
var player: CharacterBody3D
var current_state: State
var is_interactable := false

@onready var nav_agent: NavigationAgent3D = %nav_agent
@onready var current_charge: float = 0

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
func move(target_pos: Vector3) -> void:
	nav_agent.target_position = target_pos
	
	var next_positon = nav_agent.get_next_path_position()
	direction = global_position.direction_to(next_positon)
	
	if direction:
		look_at_target(direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if velocity != Vector3.ZERO:
		anim_player.play("Run")
	move_and_slide()

func register_level_manager(new_level_manager: LevelManager):
	level_manager = new_level_manager

func set_navigation_target(nav_target: Vector3):
	$StateMachine/Waiting.navigation_target = nav_target
	
func look_at_target(direction: Vector3):
	var adjusted_direction = direction
	adjusted_direction.y = 0
	
	look_at(global_position + adjusted_direction, Vector3.UP, false)


func _on_state_machine_state_transition(new_state: State) -> void:
	current_state = new_state
	print("changed state, new state: " + str(current_state))
