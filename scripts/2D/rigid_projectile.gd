class_name RigidProjectile extends RigidBody2D

@export var activation_delay: float = 0.19
@export var lifetime: float = 5

var gravity_fields: Array[Area2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_save_gravity_fields()
	_disable_gravity_fields(true)
	var delay_timer_node := Timer.new()
	delay_timer_node.name = "ActivationDelay"
	add_child(delay_timer_node)
	delay_timer_node.start(activation_delay)
	delay_timer_node.timeout.connect(_on_delay_end.bind(delay_timer_node))


func _save_gravity_fields() -> void:
	_append_array_with_nodes_of_type(GravityField, gravity_fields)


# Wouldve been perfect if array or return type was templated
func _append_array_with_nodes_of_type(type: GDScript, array: Array[Variant]) -> void:
	var children: 		Array[Node] = get_children()
	var children_next: 	Array[Node] = []
	while children.size() > 0:
		for child in children:
			if is_instance_of(child, type):
				array.append(child)
			else:
				children_next.append_array(child.get_children())
		children = children_next
		children_next = []


func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0:
		queue_free()


func _disable_gravity_fields(disable: bool) -> void:
	for gravity_field in gravity_fields:
		for child in gravity_field.get_children():
			if child is CollisionShape2D:
				child.disabled = disable


func _on_delay_end(timer: Timer) -> void:
	_disable_gravity_fields(false)
	timer.queue_free()
