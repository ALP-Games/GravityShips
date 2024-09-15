extends Area2D

@export var speed: float = 1000.0
@export var lifetime: float = 10.0

var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = Vector2.RIGHT.rotated(global_rotation)
	gravity_direction = gravity_direction.rotated(global_rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	global_position += direction * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()
