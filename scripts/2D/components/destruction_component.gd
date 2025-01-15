class_name DestructionComponent extends Component

signal on_destroy


static func core() -> ComponentCore:
	return ComponentCore.new(&"DestructionComponent")


func destroy() -> void:
	get_parent().queue_free()
	on_destroy.emit()
