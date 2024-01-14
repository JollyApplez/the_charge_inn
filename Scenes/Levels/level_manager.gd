extends Node
class_name LevelManager

@export var patron_spawn_time_min: int
@export var patron_spawn_time_max: int

@export var patron_tolerance_range_min: int
@export var patron_tolerance_range_max: int

@export var level_entrance: Node3D
@export var level_exit: Node3D
@export var patron_spawn: Node3D
@export var patron_type: Array[PackedScene]

@export var patron_max: int
@export var queue_max_length: int

var spawn_time: float
var patron_queue: Array[Patron]
var patron_total: Array[Patron]
@onready var navigation_region_3d: NavigationRegion3D = $NavigationRegion3D



func _ready() -> void:
	spawn_time = set_spawn_time()

func _process(delta: float) -> void:
	spawn_manager(delta)

func spawn_patron():
	var p = patron_type.pick_random()
	p = p.instantiate()
	patron_queue.append(p)
	patron_total.append(p)
	navigation_region_3d.add_child(p)
	p.register_level_manager(self)
	p.set_navigation_target(level_entrance.global_position)
	p.global_position = patron_spawn.global_position
	
func get_tolerance() -> float:
	var tolerance: float = randf_range(patron_tolerance_range_min, patron_tolerance_range_max)
	
	return tolerance

func get_entrance() -> Vector3:
	return level_entrance.global_position

func get_exit() -> Vector3:
	return level_exit.global_position

func set_spawn_time() -> float: 
	var new_spawn_time: float = randf_range(patron_spawn_time_min, patron_spawn_time_max)
	return new_spawn_time

func unregister_from_queue(p: Patron):
	patron_queue.erase(p)
func unregister_from_level(p: Patron):
	patron_total.erase(p)
func spawn_manager(delta: float):
	if spawn_time <= 0:
		if patron_total.size() < patron_max:
			if patron_queue.size() < queue_max_length:
				spawn_patron()
			else:
				pass 
				#Missed patron logic
			spawn_time = set_spawn_time()
	else:
		spawn_time -= delta
