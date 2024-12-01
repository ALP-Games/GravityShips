class_name SpaceMovementComponent extends AbstractComponent

@export var thrust_acceleration: float = 1500
@export var reverse_acceleration: float = 1000
@export var turn_acceleration: float = 5
@export var max_turn_speed: float = 2.0

@export var stop_linear_amount: float = 2000
@export var stop_angular_amount: float = 10

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
		var desired_direction := Vector2.UP.rotated(_parent.rotation)
		var negative_acceleration := -(_parent.linear_velocity.normalized() - desired_direction) * thrust_acceleration as Vector2
		var force_to_apply := (desired_direction * thrust_acceleration * _parent.mass) + (negative_acceleration * _parent.mass)
		_parent.apply_central_force(force_to_apply)
	
	if reverse_input:
		var desired_direction := Vector2.DOWN.rotated(_parent.rotation)
		var negative_acceleration := -(_parent.linear_velocity.normalized() - desired_direction) * reverse_acceleration as Vector2
		var force_to_apply := (desired_direction * reverse_acceleration * _parent.mass) + (negative_acceleration * _parent.mass)
		_parent.apply_central_force(force_to_apply)
	
	
	if rotation:
		# Maybe body direct state should be retrieved only once
		var inverse_inertia := PhysicsServer2D.body_get_direct_state(_parent.get_rid()).inverse_inertia
		var acceleration_defficit = (max_turn_speed - absf(_parent.angular_velocity)) / delta
		_parent.apply_torque(rotation * clamp(turn_acceleration, -acceleration_defficit, acceleration_defficit) / inverse_inertia)
	else:
		var inverse_inertia := PhysicsServer2D.body_get_direct_state(_parent.get_rid()).inverse_inertia
		if inverse_inertia != 0:
			var reverse_angular_acceleration := -_parent.angular_velocity / delta as float
			reverse_angular_acceleration = clamp(reverse_angular_acceleration, -turn_acceleration, turn_acceleration)
			_parent.apply_torque(reverse_angular_acceleration / inverse_inertia)

	if stop_input:
		var negative_acceleration := -_parent.linear_velocity.normalized() * stop_linear_amount
		_parent.apply_central_force(_parent.mass * negative_acceleration)
		
		var inverse_inertia = PhysicsServer2D.body_get_direct_state(_parent.get_rid()).inverse_inertia
		var reverse_angular_acceleration := -_parent.angular_velocity / delta as float
		reverse_angular_acceleration = clamp(reverse_angular_acceleration, -stop_angular_amount, stop_angular_amount)
		_parent.apply_torque(reverse_angular_acceleration / inverse_inertia)
