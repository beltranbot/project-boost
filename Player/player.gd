extends RigidBody3D

## How much vertical to apply when moving
@export_range(750.0, 3000.0) var thrust: float = 1000.0

## force of the torque
@export var torque_thrust: float = 100.0

var is_transitioning: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		# 3D nodes store their rotation in a matrix called a basis
		# var local_up: Vector3 = basis.y
		apply_central_force(basis.y * delta * thrust)
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))

	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))


func _on_body_entered(body: Node) -> void:
	if not is_transitioning:
		if "Hazard" in body.get_groups():
			crash_sequence()

		if "Goal" in body.get_groups():
			complete_level(body.file_path)


func crash_sequence() -> void:
	print("KABOOM!")
	set_process(false)
	is_transitioning = true
	# tween to transition between scenes
	var tween = create_tween()
	tween.tween_interval(1.0)
	#get_tree().call_deferred("reload_current_scene")
	tween.tween_callback(get_tree().reload_current_scene)
	

func complete_level(next_level_file: String) -> void:
	print("Level complete")
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(
		get_tree().change_scene_to_file.bind(next_level_file)
	)
	#get_tree().call_deferred("change_scene_to_file", next_level_file)
