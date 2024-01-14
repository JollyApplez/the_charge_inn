extends Area3D

var is_interactable := false

@onready var hud_label: Label = %HUDLabel


func _process(delta: float) -> void:
	if is_interactable:
		hud_label.show()
	else: 
		hud_label.hide()
