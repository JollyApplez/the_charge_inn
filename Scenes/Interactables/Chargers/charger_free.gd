extends State
class_name ChargerFree

@export var charger: Charger

@onready var patron_target: Marker3D = $"../../PatronTarget"

func _state_enter():
	pass

func _state_exit():
	pass

func _state_update():
	pass

func _state_physics_update():
	pass

func _on_charger_seat_patron_occupied_charger_signal(patron: Patron) -> void:
	Transitioned.emit(self, "occupied")
