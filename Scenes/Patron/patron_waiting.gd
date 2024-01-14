extends State
class_name PatronWaiting

@export var patron: Patron

var tolerance_time: float
var navigation_target: Vector3
var level_manager: LevelManager

@onready var ray: RayCast3D = $"../../Ray"
@onready var hud_label: Label = %HUDLabel


func _state_enter():
	pass

func _state_exit():
	hud_label.hide()
	level_manager.unregister_from_queue(patron)

func _state_update():
	if !level_manager: 
		level_manager = patron.level_manager
		if level_manager:
			tolerance_time = level_manager.get_tolerance()
		else: return
	
	interact_HUD_manager()
	
	
	if tolerance_time <= 0:
		_leaving_transition()

func _state_physics_update():
	var collider = ray.get_collider()
	
	if navigation_target: 
		if collider == null:
			patron.move(navigation_target)
		if patron.position.distance_to(navigation_target) <= 3:
			patron.look_at_target(patron.global_position.direction_to(patron.player.global_position))
			_tolerance_tick()

func interact_HUD_manager():
	if patron.is_interactable:
		hud_label.visible = true
		hud_label.text = "Escort to Seat"
	else: 
		hud_label.hide()

func _tolerance_tick():
	tolerance_time -= get_process_delta_time()

func _leaving_transition():
	Transitioned.emit(self, "leaving")

func _escort_transition():
	Transitioned.emit(self, "escort")
