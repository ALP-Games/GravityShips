class_name GameManager extends Node

@onready var _world_ref: Node2D = get_tree().get_current_scene()


func _ready() -> void:
	# fps lock 
	#Engine.max_fps = 60
	pass


func get_world_ref() -> Node2D:
	return _world_ref
