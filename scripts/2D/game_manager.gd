class_name GameManager extends Node

@onready var _world_ref: Node2D = get_tree().get_current_scene()


func get_world_ref() -> Node2D:
	return _world_ref

