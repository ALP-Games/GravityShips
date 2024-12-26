class_name ForceProjectile extends RigidProjectile

@export var projectile_force: float = 1000000


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	for child in gravity_fields:
		(child as ForceField).applied_force = projectile_force


func _save_gravity_fields() -> void:
	_append_array_with_nodes_of_type(ForceField, gravity_fields)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
