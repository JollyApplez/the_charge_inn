extends Node3D
class_name Charger


enum adapter_type {
	BATTERY_ADAPTER, 
	TWO_PLUG_ADAPTER,
	USB_ADAPTER,
	LAMP_ADAPTER
}

var current_adapter: adapter_type
var current_charge: Table.voltage_type
var isOccupied = false
