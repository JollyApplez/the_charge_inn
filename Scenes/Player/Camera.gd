extends Camera3D

var mouseRange := 100.0

@onready var player: CharacterBody3D = $".."
@onready var camera_ray: RayCast3D = $CameraRay
@export var z_offset = 10

var latest_valid_pos: Vector3 = Vector3.ZERO



func _physics_process(delta: float) -> void:
	
	var new_pos = global_position
	new_pos.x = player.global_position.x
	new_pos.z = player.global_position.z + z_offset
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", new_pos, .3)

func _get_mouse_position() -> Vector3:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	camera_ray.target_position = project_local_ray_normal(mouse_position) * mouseRange
	camera_ray.force_raycast_update()
	if camera_ray.is_colliding():
		latest_valid_pos = camera_ray.get_collision_point()
		return latest_valid_pos

	else:
		return latest_valid_pos
