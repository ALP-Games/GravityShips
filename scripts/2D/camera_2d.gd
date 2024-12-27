class_name FixedAspectCamera extends Camera2D

signal seeking_target(Vector2)

const BASE_RESOLUTION: Vector2 = Vector2(1920, 1080)

@export var target: Node2D = null

@export var background_viewport: SubViewport = null

@onready var _base_zoom: Vector2 = zoom

var on_process: Callable = process_nothing

var _background_camera: Camera2D = null


func _ready() -> void:
	if background_viewport:
		_background_camera = background_viewport.get_camera_2d()
		background_viewport.size = get_viewport_rect().size
		seeking_target.connect(update_background_camera)
	recalc_camera_zoom()
	if target:
		on_process = seek_target
		target.tree_exited.connect(on_target_destroyed)


func _physics_process(_delta: float) -> void:
	on_process.call(_delta)


func recalc_camera_zoom() -> void:
	var current_resolution := get_viewport_rect().size
	var height_difference := BASE_RESOLUTION.y / current_resolution.y
	var new_zoom_value := 1.0 / ((1.0 / _base_zoom.y) * height_difference)
	zoom = Vector2(new_zoom_value, new_zoom_value)
	if _background_camera:
		_background_camera.zoom = zoom


func seek_target(_delta: float) -> void:
	seeking_target.emit(target.global_position - global_position)
	global_position = target.global_position


func update_background_camera(offset: Vector2) -> void:
	_background_camera.global_position += offset


func process_nothing(_delta: float) -> void:
	pass


func on_target_destroyed() -> void:
	on_process = process_nothing
#func _process(delta: float) -> void:
	#if target:
		#global_position = target.global_position
