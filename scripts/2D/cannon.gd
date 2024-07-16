class_name Cannon extends Node2D

@export var projectile_scene: PackedScene
@export var spawner: Node2D


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		look_at(get_global_mouse_position())
		if event.button_mask == 1 and event.is_pressed():
			var projectile_instance := projectile_scene.instantiate() as Node2D
			projectile_instance.global_position = spawner.global_position
			projectile_instance.global_rotation = global_rotation
			game_manager.get_world_ref().add_child(projectile_instance)
