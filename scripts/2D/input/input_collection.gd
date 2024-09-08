class_name InputCollection extends Node2D

var _mouse_position: Vector2 = Vector2.ZERO
var _shoot_input: bool = false 
var _thrust_input: bool = false
var _reverse_input: bool = false
var _stop_input: bool = false
var _rotation_input: float = 0.0

func get_mouse_position() -> Vector2:
	return _mouse_position


func get_shoot_input() -> bool:
	return _shoot_input


func get_thrust_input() -> bool:
	return _thrust_input


func get_reverse_input() -> bool:
	return _reverse_input


func get_stop_input() -> bool:
	return _stop_input


func get_rotation_input() -> float:
	return _rotation_input


static func meta_key() -> StringName:
	return &"InputCollection"


func _enter_tree() -> void:
	child_entered_tree.connect(_on_child_entered_tree)
	# we cal also remove meta on exit tree
	#child_exiting_tree


func _on_child_entered_tree(node: Node) -> void:
	node.set_meta(meta_key(), self)


#func _ready() -> void:
	#for child in get_children():
		#child.set_meta(meta_key(), self)
