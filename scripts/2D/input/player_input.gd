class_name PlayerInput extends InputCollection


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		#_mouse_position = get_global_mouse_position()
		#look_at(get_global_mouse_position())
		if event.button_mask == 1 and event.is_pressed():
			_shoot_input = true
		#if event.button_mask == 1 and event.is_pressed():
			#
			#var projectile_instance := projectile_scene.instantiate() as Node2D
			#projectile_instance.global_position = spawner.global_position
			#projectile_instance.global_rotation = global_rotation
			#game_manager.get_world_ref().add_child(projectile_instance)


func _process(_delta: float) -> void:
	_mouse_position = get_global_mouse_position()
	_thrust_input = Input.is_action_pressed("thrust")
	_reverse_input = Input.is_action_pressed("reverse")
	_stop_input = Input.is_action_pressed("stop")
	_rotation_input = Input.get_axis("rot_left", "rot_right")


func _physics_process(_delta: float) -> void:
	call_deferred("_reset_inputs")


func _reset_inputs() -> void:
	_shoot_input = false
