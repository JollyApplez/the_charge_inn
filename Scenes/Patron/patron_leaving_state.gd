extends State
class_name PatronLeaving

@export var patron: Patron

var navigation_target: Vector3

func _state_enter():
	navigation_target = patron.level_manager.get_exit()
	print("Leaving")

func _state_exit():
	pass

func _state_update():
	pass

func _state_physics_update():
	if navigation_target:
		patron.move(navigation_target)
		if patron.global_position.distance_to(navigation_target) <= 1: 
			patron.queue_free()
