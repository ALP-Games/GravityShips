class_name Component extends Node

static func component_name() -> StringName:
	assert(false, "component_name function must be overriden by component!")
	return &""


static func invoke_on_component(component_type: GDScript,\
								component_parent: Node,\
								invocation: Callable) -> bool:
	if not component_parent.has_meta(component_type.component_name()):
		return false
	invocation.call(component_parent.get_meta(component_type.component_name()))
	return true


static func get_component(component_type: GDScript, component_parent: Node) -> Component:
	if not component_parent.has_meta(component_type.component_name()):
		return null
	return component_parent.get_meta(component_type.component_name())


func _enter_tree() -> void:
	get_parent().set_meta(component_name(), self)


func _exit_tree() -> void:
	get_parent().remove_meta(component_name())
