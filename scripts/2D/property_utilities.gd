class_name PropertyUtilities

static func get_nested_property(node: Node, path: String) -> Variant:
	var previous_pos := 0
	var delimiter_pos := path.find(".")
	var current_property_name := path.substr(0, delimiter_pos)
	var property = node.get(current_property_name)
	while delimiter_pos != -1:
		previous_pos = delimiter_pos + 1
		delimiter_pos = path.find(".", previous_pos)
		current_property_name = path.substr(previous_pos, delimiter_pos)
		property = property.get(current_property_name)
	return property
