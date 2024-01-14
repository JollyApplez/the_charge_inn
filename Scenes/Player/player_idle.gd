extends State
class_name PlayerIdle

@export var player: Player

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
	player.player_look()


func _on_interact_ray_patron_collision_signal(node: Node3D, state: State) -> void:
	if get_parent().current_state == self: 
		interactable_target = node
		interactable_target.is_interactable = true
		if Input.is_action_just_pressed("interact"):
			Transitioned.emit(self, "interacting")
