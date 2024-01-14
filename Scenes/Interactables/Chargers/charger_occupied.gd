extends State
class_name ChargerOccupied

@export var charger: Charger

var current_patron: Patron
var patron_voltage_type: Table.voltage_type
var patron_adapter_type: Charger.adapter_type
var patron_load: int

func _state_enter():
	if current_patron:
		patron_voltage_type = current_patron.voltage_type
		patron_adapter_type = current_patron.adapter_type
		patron_load = current_patron.load_per_sec
		
		charger.table_station.power_cycle.connect(power_cycle)
		charger.table_station.voltage_type_change.connect(power_cycle)
		current_patron.fully_charged.connect(_on_charger_seat_patron_leaving_signal)
		
		if patron_adapter_type == charger.current_adapter:
			if charger.table_station.current_voltage_type == patron_voltage_type:
				charger.table_station._add_load(patron_load)

func _state_exit():
	disconnect("power_cycle", power_cycle)
	charger.table_station.reduce_load(patron_load)
	current_patron = null
	patron_voltage_type = Table.voltage_type.NO_VOLTAGE
	patron_load = 0

func _state_update():
	pass

func _state_physics_update():
	pass

func power_cycle(voltage: Table.voltage_type):
	if patron_adapter_type == charger.current_adapter:
		if voltage == patron_voltage_type:
			current_patron.current_charge += patron_load
			
func table_voltage_type_change(voltage_type: Table.voltage_type):
	if patron_voltage_type == voltage_type:
		charger.table_station.add_load(patron_load)

func _on_charger_seat_patron_occupied_charger_signal(patron: Patron) -> void:
	current_patron = patron
	_state_enter()

func _on_charger_seat_patron_leaving_signal() -> void:
	Transitioned.emit(self, "free")
