extends Camera2D

const BASE_RESOLUTION: Vector2 = Vector2(1920, 1080)

@export var target: Node2D = null

#var _base_zoom: Vector2 = Vector2.ZERO


func _ready() -> void:
	var current_resolution := get_viewport_rect().size
	var height_difference := BASE_RESOLUTION.y / current_resolution.y
	var new_zoom_value := 1.0 / ((1.0 / zoom.y) * height_difference)
	zoom = Vector2(new_zoom_value, new_zoom_value)


func _physics_process(delta: float) -> void:
	if target:
		global_position = target.global_position


#func _process(delta: float) -> void:
	#if target:
		#global_position = target.global_position
