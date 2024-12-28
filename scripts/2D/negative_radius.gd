class_name BackgroundTop extends TextureRect

@export var origin_object: Node2D = null
@export_group("Effect Radius")
@export_subgroup("Radius")
@export var _radius_node: NodePath
@export var _radius_property_path: String
@export_subgroup("Radius changed")
@export var _radius_change_node: NodePath
@export var _radius_change_signal_path: String

@onready var camera: Camera2D = get_viewport().get_camera_2d()
var _aspect: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_aspect()
	get_viewport().size_changed.connect(_set_aspect)
	_set_radius()
	# TODO: figure out what you should monitor to update the radius
	if not _radius_change_node.is_empty():
		var radius_change_node := get_node(_radius_change_node)
		var on_change_signal := PropertyUtilities.\
								get_nested_property(radius_change_node,\
											_radius_change_signal_path) as Signal
		on_change_signal.connect(_set_radius)


func _set_aspect() -> void:
	_aspect = Vector2(get_viewport_rect().size.x / get_viewport_rect().size.y, 1.0)
	(material as ShaderMaterial).set_shader_parameter("aspect", \
														_aspect)


func _set_radius() -> void:
	var radius_node := get_node(_radius_node)
	var radius := PropertyUtilities.get_nested_property(radius_node, \
												_radius_property_path) as float
	var radius_in_shader_units = (radius * camera.zoom.y) / get_viewport_rect().size.y
	(material as ShaderMaterial).set_shader_parameter("radius", \
													radius_in_shader_units)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	var target_pos = ((origin_object.global_position * camera.zoom.y) + \
	origin_object.get_canvas_transform().origin) / get_viewport_rect().size * _aspect
	
	(material as ShaderMaterial).set_shader_parameter("point",\
													target_pos)
