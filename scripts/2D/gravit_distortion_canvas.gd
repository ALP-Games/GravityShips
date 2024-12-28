class_name GravityDistortion extends ColorRect

@export var gravity_source: Node2D

@onready var camera: Camera2D = get_viewport().get_camera_2d()

var _aspect: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_aspect()
	get_viewport().size_changed.connect(_set_aspect)


func _set_aspect() -> void:
	_aspect = Vector2(get_viewport_rect().size.x / get_viewport_rect().size.y, 1.0)
	(material as ShaderMaterial).set_shader_parameter("aspect", \
														_aspect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_pos = ((gravity_source.global_position * camera.zoom.y) + \
		gravity_source.get_canvas_transform().origin) / get_viewport_rect().size * \
																			_aspect
	
	(material as ShaderMaterial).set_shader_parameter("gravity_point",\
		target_pos)
