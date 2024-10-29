class_name PlayerInput extends InputCollection


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		print(event.position)
		
		#_mouse_position = get_global_mouse_position()
		#look_at(get_global_mouse_position())
		_shoot_input = event.button_mask == 1 and event.is_pressed()
		#if event.button_mask == 1 and event.is_pressed():
			#
			#var projectile_instance := projectile_scene.instantiate() as Node2D
			#projectile_instance.global_position = spawner.global_position
			#projectile_instance.global_rotation = global_rotation
			#game_manager.get_world_ref().add_child(projectile_instance)


func _process(delta: float) -> void:
	#_mouse_position = get_mouse_position()
	_mouse_position = game_manager.get_root_scene().get_local_mouse_position()
	_thrust_input = Input.is_action_pressed("thrust")
	_reverse_input = Input.is_action_pressed("reverse")
	_stop_input = Input.is_action_pressed("stop")
	_rotation_input = Input.get_axis("rot_left", "rot_right")


func _physics_process(delta: float) -> void:
	print("Mouse position ", _mouse_position)
	pass
	#print("local mouse - ", get_mouse_position(), "; global mouse - ", get_parent().get_parent().get_parent().get_global_mouse_position(), ";")
	#_mouse_position = get_global_mouse_position()
	#_thrust_input = Input.is_action_pressed("thrust")
	#_reverse_input = Input.is_action_pressed("reverse")
	#_stop_input = Input.is_action_pressed("stop")
	#_rotation_input = Input.get_axis("rot_left", "rot_right")
