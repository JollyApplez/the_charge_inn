extends State
class_name PlayerEscorting

@export var player : Player

func _state_enter():
	pass

func _state_exit():
	pass

func _state_update():
	player.player_move()

func _state_physics_update():
	pass
