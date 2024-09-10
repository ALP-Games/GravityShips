extends Node2D

const RENDER_SCALE_MAX: float = 10.0
const RENDER_SCALE_MIN: float = 0.1

@export_range(RENDER_SCALE_MIN, RENDER_SCALE_MAX, 0.01) var render_scale: float = 1.0
@export var slider: Slider = null

var viewport: SubViewport = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is SubViewport:
			viewport = child
			break
	assert(viewport, "SubViewport is not present in the children. Add it.")
	_recalc_resolution()
	_init_slider()


func _recalc_resolution() -> void:
	var current_resolution := get_viewport_rect().size
	viewport.size.x = current_resolution.x * render_scale
	viewport.size.y = current_resolution.y * render_scale
	var camera = viewport.get_camera_2d()
	if camera is FixedAspectCamera:
		camera.recalc_camera_zoom()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var camera = viewport.get_camera_2d()
	#if camera is FixedAspectCamera:
		#camera.recalc_camera_zoom()
	pass


func _init_slider() -> void:
	if !slider:
		return
	slider.value = remap(render_scale, RENDER_SCALE_MIN, RENDER_SCALE_MAX, slider.min_value, slider.max_value)
	slider.value_changed.connect(_slider_value_changed)


func _slider_value_changed(value: float) -> void:
	render_scale = remap(value, slider.min_value, slider.max_value, RENDER_SCALE_MIN, RENDER_SCALE_MAX)
	_recalc_resolution()
