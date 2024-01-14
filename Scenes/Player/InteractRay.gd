extends RayCast3D

var interactable_cache: Node3D

@export var player: Player

signal interactable_collision_signal(node: Node3D, state: State)



func _process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		interactable_cache = collider
		if collider is Patron:
			var patron_node: Patron = collider
			var patron_state: State = patron_node.current_state
			interactable_collision_signal.emit(patron_node, patron_state)
	else: 
		if interactable_cache:
				if interactable_cache.is_interactable:
					interactable_cache.is_interactable = false
					interactable_cache = null
	
	
