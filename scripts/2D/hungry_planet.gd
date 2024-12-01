class_name HungryPlanet extends RigidBody2D

@onready var mouth: Area2D = $Mouth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouth.body_entered.connect(_body_entered_mouth)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass


func _body_entered_mouth(node: Node2D) -> void:
	if node != self:
		node.queue_free()
