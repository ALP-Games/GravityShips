class_name GravityDistortion extends ColorRect

@export var gravity_source: Node2D

@onready var camera: Camera2D = get_viewport().get_camera_2d()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_pos = ((gravity_source.global_position * camera.zoom.y) + \
	gravity_source.get_canvas_transform().origin) / get_viewport_rect().size
	
	(material as ShaderMaterial).set_shader_parameter("gravity_point",\
		target_pos)
