extends Camera3D

@export var target: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if target:
		global_position.x = target.global_position.x
		global_position.y = target.global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
