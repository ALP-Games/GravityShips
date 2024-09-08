class_name CannonComponent extends AbstractComponent


@export var projectile_scene: PackedScene
@export var cannon_tower: Node2D
@export var spawner: Node2D

var _input_collection: InputCollection = null


static func component_name() -> StringName:
	return &"CannonComponent"


func _enter_tree() -> void:
	super()
	var parent := get_parent()
	assert(parent.has_meta(InputCollection.meta_key()), "Space movement controller requires Input collection !")
	_input_collection = parent.get_meta(InputCollection.meta_key())


func _physics_process(delta: float) -> void:
	cannon_tower.look_at(_input_collection.get_mouse_position())
	if _input_collection.get_shoot_input():
		var projectile_instance := projectile_scene.instantiate() as Node2D
		projectile_instance.global_position = spawner.global_position
		projectile_instance.global_rotation = cannon_tower.global_rotation
		game_manager.get_world_ref().add_child(projectile_instance)
