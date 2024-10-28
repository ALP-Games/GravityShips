class_name SpaceMovementComponent extends AbstractComponent

@export var thrust_acceleration: float = 1500
@export var reverse_acceleration: float = 1000
@export var turn_acceleration: float = 10000

@export var stop_linear_amount: float = 2000
@export var stop_angular_amount: float = 300000

var _parent: RigidBody2D = null
var _input_collection: InputCollection = null


static func component_name() -> StringName:
	return &"SpaceMovementComponent"


func _enter_tree() -> void:
	super()
	_parent = get_parent()
	assert(_parent.has_meta(InputCollection.meta_key()), "Space movement controller requires Input collection !")
	_input_collection = _parent.get_meta(InputCollection.meta_key())


func _physics_process(delta) -> void:
	# move to controller component
	var thrust_input := _input_collection.get_thrust_input()
	var reverse_input := _input_collection.get_reverse_input()
	var stop_input := _input_collection.get_stop_input()
	var rotation := _input_collection.get_rotation_input()
	
	if thrust_input:
		_parent.apply_central_force(Vector2.UP.rotated(_parent.rotation) *\
									thrust_acceleration * _parent.mass)
	
	if reverse_input:
		_parent.apply_central_force(Vector2.DOWN.rotated(_parent.rotation) *\
									reverse_acceleration * _parent.mass)
	
	if rotation:
		_parent.apply_torque(rotation * turn_acceleration * _parent.mass)

	if stop_input:
		_parent.apply_central_force(_parent.mass * -_parent.linear_velocity.normalized() *\
			clampf(_parent.linear_velocity.length() / delta, 0, stop_linear_amount))
		
		var torque_direction = -1 if _parent.angular_velocity >= 0 else 1
		_parent.apply_torque(_parent.mass * torque_direction * stop_angular_amount)
