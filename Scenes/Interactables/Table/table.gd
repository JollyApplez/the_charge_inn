extends Node3D
class_name Table

enum voltage_type {
	LOW_VOLTAGE, 
	HIGH_VOLTAGE,
	NO_VOLTAGE
}

var current_voltage_type: voltage_type: 
	set(value):
		voltage_type_change.emit(value)
		voltage_type_label.text = str(voltage_type.find_key(value))
var seats: Array[Charger]
var load_per_sec := 0.0:
	set(value):
		load_label.text = "Load/s: " + str(value)

@onready var voltage_type_label: Label = %VoltageTypeLabel
@onready var capacity_label: Label = %CapacityLabel
@onready var load_label: Label = %LoadLabel



var capacity := 0.0:
	set(value):
		capacity_label.text = "Capacity: " + str(capacity)
		if value < capacity: #discharge
			if value >= 0:
				power_cycle.emit(current_voltage_type)
			else:
				capacity = 0
		else: 
			pass # charged

signal power_cycle(voltage_type: voltage_type)
signal voltage_type_change(voltage_type: voltage_type)

func _ready() -> void:
	current_voltage_type = voltage_type.NO_VOLTAGE
	for child in $ChargerLocations.get_children():
		seats.append(child)

func _add_load(load):
	load_per_sec += load

func _on_power_cycle_timeout() -> void:
	capacity -= load_per_sec

