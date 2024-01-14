extends Node3D
class_name Table

enum voltage_type {
	LOW_VOLTAGE, 
	HIGH_VOLTAGE,
	NO_VOLTAGE
}

var current_voltage_type: voltage_type: 
	set(value):
		voltage_type_label.text = str(voltage_type.find_key(value))
		current_voltage_type = value
		voltage_type_change.emit(value)
		load_per_sec = 0
var seats: Array[Charger]
var load_per_sec := 0.0:
	set(value):
		load_label.text = "Load/s: " + str(value)
		load_per_sec = value
var capacity := 0.0:
	set(value):
		capacity_label.text = "Capacity: " + str(capacity)
		print(value)
		print(capacity)
		if value < capacity: #discharge
			if value >= 0:
				power_cycle.emit(current_voltage_type)
				capacity = value
			else:
				capacity = 0
		else: 
			capacity = value


@onready var voltage_type_label: Label = %VoltageTypeLabel
@onready var capacity_label: Label = %CapacityLabel
@onready var load_label: Label = %LoadLabel


signal power_cycle(voltage_type: voltage_type)
signal voltage_type_change(voltage_type: voltage_type)

func _ready() -> void:
	current_voltage_type = voltage_type.NO_VOLTAGE 
	for child in $ChargerLocations.get_children():
		if child is Charger:
			seats.append(child)
			voltage_type_change.connect(child.voltage_type_change)

	#should be no_voltage
	current_voltage_type = voltage_type.LOW_VOLTAGE
	capacity = 1000 

func _add_load(load: float):
	load_per_sec += load

func reduce_load(load: float):
	load_per_sec -= load

func _on_power_cycle_timeout() -> void:
	if load_per_sec > 0:
		capacity -= load_per_sec

