extends RayCast3D

var interactable_cache: Node3D:
	set(value):
		if value != interactable_cache:
			if interactable_cache is Charger:
				interactable_cache.is_interactable = false
		interactable_cache = value

@export var player: Player

signal patron_collision_signal(node: Node3D, state: State)
signal charger_collision_signal(charger: Charger)


func _process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider is Patron:
			interactable_cache = collider
			var patron_node: Patron = collider
			var patron_state: State = patron_node.current_state
			patron_collision_signal.emit(patron_node, patron_state)
		
		if collider.get_parent() is Charger or collider is Charger:
			if collider is Charger:
				charger_collision_signal.emit(collider)
			else:
				collider = collider.get_parent()
				charger_collision_signal.emit(collider)
			interactable_cache = collider
	else: 
		if interactable_cache:
			interactable_cache.is_interactable = false
			interactable_cache = null
	
	
