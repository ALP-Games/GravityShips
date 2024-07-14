@tool
class_name ShipPart_tool extends ShipPart


func _enter_tree() -> void:
	super()
	_add_collision_shape()
	var parent := get_parent()
	if parent and not parent.ready.is_connected(_on_scene_ready):
		get_parent().ready.connect(_on_scene_ready)


#func _exit_tree():
	#super()


func _add_collision_shape() -> void:
	if not Engine.is_editor_hint():
		return
	
	for child in get_children():
		if child is CollisionShape3D:
			return
	var collision_shape := CollisionShape3D.new()
	add_child(collision_shape)
	var parent := get_parent()
	if parent:
		if parent.owner:
			collision_shape.owner = parent.owner
		else:
			collision_shape.owner = parent
	else:
		collision_shape.owner = self
	collision_shape.name = &"CollisionShape3D"


func _on_scene_ready() -> void:
	if not Engine.is_editor_hint():
		var base_node = ShipPart.new()
		#get_parent().add_child(base_node)
		replace_by(base_node)
		_copy_properties_and_move_children(base_node)
		print("Initialized node ", base_node.name, " as ShipPart")
		queue_free()
	else:
		print("Ship part: ", name, " initialized as tool.")


func _copy_properties_and_move_children(node: ShipPart) -> void:
	var node_properties = node.get_property_list()
	for property in node_properties:
		if property.name == "script":
			continue
		if property.name == "name":
			var name_property = get(property.name)
			name = name + '_'
			node.set(property.name, name_property)
			continue
		if property.name == "linear_velocity":
			pass
			#continue
		node.set(property.name, get(property.name))
	
	for child in get_children():
		child.reparent(node)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass
