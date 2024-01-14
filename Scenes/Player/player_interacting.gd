extends State
class_name PlayerInteracting

@onready var interact_ray: RayCast3D = $"../../InteractRay"

var interactable : Node3D
var interactable_state

func _state_enter():
	pass

func _state_exit():
	pass

func _state_update():
	if interactable is Patron and interactable_state is PatronWaiting:
		interactable_state._escort_transition()
		interactable.is_interactable = false
		Transitioned.emit(self, "escorting")

func _state_physics_update():
	pass


func _on_interact_ray_interactable_collision_signal(node: Node3D, state: State) -> void:
	interactable = node
	
	if node.current_state:
		interactable_state = node.current_state
