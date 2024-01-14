extends Node3D
class_name Charger


enum adapter_type {
	BATTERY_ADAPTER, 
	TWO_PLUG_ADAPTER,
	USB_ADAPTER,
	LAMP_ADAPTER
}

@export var current_adapter: adapter_type
@export var current_voltage: Table.voltage_type

var current_state: State
var table_station: Table
var is_interactable := false:
	set(value):
		if value: 
			hud_label.show()
		else: 
			hud_label.hide()
			

@onready var patron_target: Marker3D = $PatronTarget
@onready var hud_label: Label = %HUDLabel

signal patron_occupied_charger_signal(patron: Patron)

func _ready() -> void:
	table_station = get_parent().get_parent()
	current_voltage = table_station.current_voltage_type
	

func _process(delta: float) -> void:
	pass

func voltage_type_change(new_voltage: Table.voltage_type):
	current_voltage = new_voltage

func _on_state_machine_state_transition(new_state: State) -> void:
	current_state = new_state
