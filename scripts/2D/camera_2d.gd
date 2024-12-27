class_name FixedAspectCamera extends Camera2D

signal seeking_target(Vector2)
signal camera_zoom_changed(Vector2)

const BASE_RESOLUTION: Vector2 = Vector2(1920, 1080)

@export var target: Node2D = null

@export var background_viewport: SubViewport = null

@onready var _base_zoom: Vector2 = zoom

var on_process: Callable = process_nothing

var _background_camera: Camera2D = null


func _ready() -> void:
	if background_viewport:
		_init_background_viewport()
	recalc_camera_zoom()
	if target:
		on_process = seek_target
		target.tree_exited.connect(on_target_destroyed)


func _init_background_viewport() -> void:
	_background_camera = background_viewport.get_camera_2d()
	background_viewport.size = get_viewport_rect().size
	var update_background_camera = func (offset: Vector2) -> void:
		_background_camera.global_position += offset
	seeking_target.connect(update_background_camera)
	var set_background_camera_zoom = func (camera_zoom: Vector2) -> void:
		_background_camera.zoom = camera_zoom
	camera_zoom_changed.connect(set_background_camera_zoom)


func _physics_process(_delta: float) -> void:
	on_process.call(_delta)


func recalc_camera_zoom() -> void:
	var current_resolution := get_viewport_rect().size
	var height_difference := BASE_RESOLUTION.y / current_resolution.y
	var new_zoom_value := 1.0 / ((1.0 / _base_zoom.y) * height_difference)
	var new_zoom_vector := Vector2(new_zoom_value, new_zoom_value)
	zoom = new_zoom_vector
	camera_zoom_changed.emit(new_zoom_vector)


func seek_target(_delta: float) -> void:
	seeking_target.emit(target.global_position - global_position)
	global_position = target.global_position


func process_nothing(_delta: float) -> void:
	pass


func on_target_destroyed() -> void:
	on_process = process_nothing
#func _process(delta: float) -> void:
	#if target:
		#global_position = target.global_position
