extends State
class_name PlayerEscorting

@export var player : Player

var charger_target: Charger:
	set(value):
		if charger_target != null:
			if charger_target != value:
				charger_target.is_interactable = false
		charger_target = value

func _state_enter():
	pass

func _state_exit():
	if charger_target.is_interactable: 
		charger_target.is_interactable = false
		

func _state_update():
	player.player_move()

func _state_physics_update():
	pass


func _on_interact_ray_charger_collision_signal(charger: Charger) -> void:
	if get_parent().current_state == self: 
		charger.is_interactable = true
		charger_target = charger
		if Input.is_action_just_pressed("interact"):
			player.assigned_seat_signal.emit(charger)
			Transitioned.emit(self, "idle")
