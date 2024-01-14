extends State
class_name PatronEscort

@export var patron: Patron

@onready var nav_target
@onready var player

var is_being_escorted := false
var have_seat_assigned := false

func _state_enter():
	player = patron.player
	nav_target = player.global_position
	is_being_escorted = true

func _state_exit():
	pass

func _state_update():
	pass

func _state_physics_update():
	if is_being_escorted: 
		being_escorted()
	if have_seat_assigned:
		patron.move(nav_target)

func being_escorted():
	nav_target = player.global_position
	if patron.global_position.distance_to(nav_target) > 3:
		patron.move(nav_target)

func set_assign_seat(seat_pos):
	nav_target = seat_pos
	is_being_escorted = false
	have_seat_assigned = true

func assigned_seat(): 
	patron.move(nav_target)
