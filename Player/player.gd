extends RigidBody3D

## How much vertical to apply when moving
@export_range(750.0, 3000.0) var thrust: float = 1000.0

## force of the torque
@export var torque_thrust: float = 100.0

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
	if "Hazard" in body.get_groups():
		crash_sequence()

	if "Goal" in body.get_groups():
		complete_level()


func crash_sequence() -> void:
	print("KABOOM!")
	get_tree().reload_current_scene()
	

func complete_level() -> void:
	print("Level complete")
	get_tree().quit()
