extends State
class_name PatronWaiting

@export var patron: Patron

var tolerance_time: float
var navigation_target: Vector3
var level_manager: LevelManager

@onready var ray: RayCast3D = $"../../Ray"


func _state_enter():
	patron.canMove = true

func _state_exit():
	patron.navigation_target = null

func _state_update():
	if !level_manager: 
		level_manager = patron.level_manager
		if level_manager:
			tolerance_time = level_manager.get_tolerance()
			print("Tolerance time: " + str(tolerance_time))
		else: return
		
	var collider = ray.get_collider()
	if collider != null:
		patron.canMove = false
	
	
	tolerance_time -= get_process_delta_time()
	
	if tolerance_time <= 0:
		pass

func _state_physics_update():
	pass
