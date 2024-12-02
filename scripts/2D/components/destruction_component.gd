class_name DestructionComponent extends Component

signal on_destroy


static func component_name() -> StringName:
	return &"DestructionComponent"


func destroy() -> void:
	get_parent().queue_free()
	on_destroy.emit()
