class_name ThrusterComponent  extends ShipPartComponent

@export var thrust_amount: float = 10
@export var activation_input: InputEventKey

var thruster_part: ShipPart = null
var active: bool = false


static func component_name() -> StringName:
	return &"ThrusterComponent"


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	
	var key_input_event: InputEventKey = event
	
	if activation_input.keycode == key_input_event.keycode:
		active = key_input_event.pressed


func _physics_process(delta):
	print(thruster_part.global_rotation)
	if active:
		thruster_part.apply_central_force(Vector3(0, 1, 0).rotated(Vector3(0, 0, 1), \
											thruster_part.global_rotation.z) * thrust_amount)


# Called when the node enters the scene tree for the first time.
func _ready():
	thruster_part = get_parent()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("Active: ", active)
	pass
