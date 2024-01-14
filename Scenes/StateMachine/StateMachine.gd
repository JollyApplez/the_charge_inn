extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

signal state_transition(new_state: State)

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state._state_enter()
		current_state = initial_state
		state_transition.emit(current_state)
	
func _process(delta: float) -> void:
	if current_state: 
		current_state._state_update()


func _physics_process(delta: float) -> void:
	if current_state: 
		current_state._state_physics_update()


func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return

	if current_state: 
		current_state._state_exit()
	
	new_state._state_enter()
	
	current_state = new_state
	state_transition.emit(current_state)
