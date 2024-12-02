class_name HungryPlanet extends RigidBody2D

@onready var mouth: Area2D = $Mouth
@onready var center_blocker: StaticBody2D = $CenterOfGravityBlocker

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouth.body_entered.connect(_body_entered_mouth)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass


func _body_entered_mouth(node: Node2D) -> void:
	if node != self and node != center_blocker:
		var eat := func (component: DestructionComponent):
			component.destroy()
		Component.invoke_on_component(DestructionComponent, node, eat)
		#node.queue_free()
