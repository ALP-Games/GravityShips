class_name SpaceMovementComponent extends AbstractComponent

@export var thrust_acceleration: float = 1500
@export var reverse_acceleration: float = 1000
@export var turn_acceleration: float = 10000

@export var stop_linear_amount: float = 800
@export var stop_angular_amount: float = 1000000

var _parent: RigidBody2D = null


static func component_name() -> StringName:
	return &"SpaceMovementComponent"


func _ready():
	_parent = get_parent()


func _physics_process(delta):
	# move to controller component
	var thrust_input := Input.is_action_pressed("thrust")
	var reverse_input := Input.is_action_pressed("reverse")
	var stop_input := Input.is_action_pressed("stop")
	var rotation := Input.get_axis("rot_left", "rot_right")
	
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
		
		_parent.apply_torque(_parent.mass *\
			-clampf(_parent.angular_velocity * 5000, -stop_angular_amount, stop_angular_amount))
