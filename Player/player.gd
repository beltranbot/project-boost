extends RigidBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		# 3D nodes store their rotation in a matrix called a basis
		# var local_up: Vector3 = basis.y
		apply_central_force(basis.y * delta * 1000.0)
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, 100.0 * delta))

	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -100.0 * delta))


func _on_body_entered(body: Node) -> void:
	if "Hazard" in body.get_groups():
		print("You lose!")

	if "Goal" in body.get_groups():
		print("You win!")
