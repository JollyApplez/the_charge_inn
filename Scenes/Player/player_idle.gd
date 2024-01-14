extends State
class_name PlayerIdle

var interactable_target: Node3D

func _state_enter():
	pass

func _state_exit():
	if interactable_target: 
		interactable_target.is_interactable = false
		interactable_target = null

func _state_update():
	
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		Transitioned.emit(self, "moving")

func _state_physics_update():
	if interactable_target: 
		if Input.is_action_just_pressed("interact"):
				Transitioned.emit(self, "interacting")
		


func _on_interact_ray_interactable_collision_signal(node: Node3D, state: State) -> void:
	if get_parent().current_state == self: 
		interactable_target = node
		if interactable_target is Patron: 
			interactable_target.is_interactable = true
			

