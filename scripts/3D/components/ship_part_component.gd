class_name ShipPartComponent extends Node


static func component_name() -> StringName:
	assert(false, "component_name function must be overriden by component!")
	return &""


func _enter_tree() -> void:
	get_parent().set_meta(component_name(), self)


func _exit_tree() -> void:
	get_parent().remove_meta(component_name())
