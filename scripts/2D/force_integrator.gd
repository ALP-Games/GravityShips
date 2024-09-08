class_name ForceIntegrator extends RigidBody2D

signal on_integrate_forces(state: PhysicsDirectBodyState2D)


func _enter_tree() -> void:
	if not contact_monitor:
		contact_monitor = true
	if max_contacts_reported < 1:
		max_contacts_reported = 4


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	on_integrate_forces.emit(state)
	print("integrated")
