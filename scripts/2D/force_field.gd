class_name ForceField extends Area2D

@export var force_direction: Vector2 = Vector2(1, 0):
	set(value):
		force_direction = value.normalized()
@export var applied_force: float = 200

var _objects_in_field: Array[RigidBody2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		body.sleeping = false
		_objects_in_field.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body is RigidBody2D:
		_objects_in_field.erase(body)


func _physics_process(delta: float) -> void:
	var rotated_angle := force_direction.rotated(global_rotation)
	for object in _objects_in_field:
		# Maybe this could be applying force on some specific dot in the body?
		# But for that we would need to know where the body is in relation to the field
		
		# Also the force only from one field should be applied
		object.apply_central_force(rotated_angle * applied_force)
