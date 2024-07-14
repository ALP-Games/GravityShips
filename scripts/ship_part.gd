class_name ShipPart extends RigidBody3D

@export var health: int = 100

func _enter_tree():
	axis_lock_angular_x = true
	axis_lock_angular_y = true
	axis_lock_linear_z = true


func _exit_tree():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is ShipPart:
			var joint = PinJoint3D.new()
			add_child(joint)
			joint.node_a = self.get_path()
			joint.node_b = child.get_path()
			joint.exclude_nodes_from_collision = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
