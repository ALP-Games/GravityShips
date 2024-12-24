class_name CannonComponent extends Component


@export var projectile_scene: PackedScene
@export var cannon_tower: Node2D
@export var spawner: Node2D
@export var shot_velocity: float = 3000

var _input_collection: InputCollection = null
var _parent: RigidBody2D = null


static func component_name() -> StringName:
	return &"CannonComponent"


func _enter_tree() -> void:
	super()
	_parent = get_parent()
	assert(_parent.has_meta(InputCollection.meta_key()), "Space movement controller requires Input collection !")
	_input_collection = _parent.get_meta(InputCollection.meta_key())


func _physics_process(_delta: float) -> void:
	cannon_tower.look_at(_input_collection.get_mouse_position())
	if _input_collection.get_shoot_input():
		var projectile_instance := projectile_scene.instantiate() as RigidProjectile
		projectile_instance.global_position = spawner.global_position
		projectile_instance.global_rotation = cannon_tower.global_rotation
		game_manager.get_world_ref().add_child(projectile_instance)
		projectile_instance.linear_velocity = _parent.linear_velocity
		projectile_instance.linear_velocity += Vector2.from_angle(cannon_tower.global_rotation) * shot_velocity
		#for gravity_field in projectile_instance.gravity_fields:
			#gravity_field.gravity_direction = gravity_field.gravity_direction.rotated(cannon_tower.global_rotation)
