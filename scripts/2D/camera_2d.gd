class_name FixedAspectCamera extends Camera2D

const BASE_RESOLUTION: Vector2 = Vector2(1920, 1080)

@export var target: Node2D = null

@onready var _base_zoom: Vector2 = zoom

var on_process: Callable = process_nothing


func _ready() -> void:
	recalc_camera_zoom()
	if target:
		on_process = seek_target
		var destruction := Component.get_component(DestructionComponent, target) as DestructionComponent
		if destruction:
			destruction.on_destroy.connect(on_target_destroyed)


func _physics_process(_delta: float) -> void:
	on_process.call(_delta)


func recalc_camera_zoom() -> void:
	var current_resolution := get_viewport_rect().size
	var height_difference := BASE_RESOLUTION.y / current_resolution.y
	var new_zoom_value := 1.0 / ((1.0 / _base_zoom.y) * height_difference)
	zoom = Vector2(new_zoom_value, new_zoom_value)


func seek_target(_delta: float) -> void:
	global_position = target.global_position


func process_nothing(_delta: float) -> void:
	pass


func on_target_destroyed() -> void:
	on_process = process_nothing
#func _process(delta: float) -> void:
	#if target:
		#global_position = target.global_position
