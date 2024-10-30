class_name RigidProjectile extends RigidBody2D

@export var gravity_fields: Array[Area2D] = []
@export var activation_delay: float = 0.19
@export var lifetime: float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_disable_gravity_fields(true)
	var delay_timer_node := Timer.new()
	delay_timer_node.name = "ActivationDelay"
	add_child(delay_timer_node)
	delay_timer_node.start(activation_delay)
	delay_timer_node.timeout.connect(_on_delay_end.bind(delay_timer_node))


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
