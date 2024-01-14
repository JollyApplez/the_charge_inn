extends State
class_name PatronCharging

@export var patron: Patron

func _state_enter():
	print("entered Charging state")

func _state_exit():
	pass

func _state_update():
	pass

func _state_physics_update():
	pass



func _on_patron_base_fully_charged() -> void:
	Transitioned.emit(self, "leaving")
